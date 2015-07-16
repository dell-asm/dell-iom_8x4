#This class is called by the puppet frame work for retrieving the facts. It retrieves the facts and initializes the switch variables.
require 'puppet'
require 'puppet/util'
#require 'puppet/util/network_device/iom_8x4/model/switch'

module PuppetX
  module Iom8x4
    class Transport

      attr_accessor :enable_password, :switch, :session, :crypt

      def initialize(certname, options={})
          if options[:device_config]
            device_conf = options[:device_config]
          else
            require 'asm/device_management'
            device_conf = ASM::DeviceManagement.parse_device_config(certname)
          end
        scheme = device_conf[:scheme]

        @enable_password = options[:enable_password] || device_conf[:arguments]['enable']

        unless @session
          require "puppet_x/iom_8x4/ssh"
          @session = PuppetX::Iom8x4::Ssh.new(true)
          @session.host = device_conf[:host]
          @session.port = device_conf[:port] || 22
          if device_conf[:arguments]['credential_id']
            require 'asm/cipher'
            cred = ASM::Cipher.decrypt_credential(device_conf[:arguments]['credential_id'])
            @session.user = cred.username
            @session.password = cred.password
          else
            @session.user = device_conf[:user]
            @session.password = device_conf[:password]
          end
        end
        @session.default_prompt = /[#>]\s?\z/n
        connect_session
        init_facts
        #init_switch  
      end

      def override_using_credential_id
        if id = @query.fetch('credential_id', []).first
          require 'asm/cipher'
          cred = ASM::Cipher.decrypt_credential(id)
          @session.user = cred.username
          @session.password = cred.password
        end
      end

      def decrypt(master, str)
        cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
        cipher.decrypt
        cipher.key = key = OpenSSL::Digest::SHA512.new(master).digest
        out = cipher.update(str)
        out << cipher.final
        return out
      end

      def parse_enable(query)
        return $1 if query =~ /enable=(.*)/
      end

      def connect_session
        session.connect
        login
        check_ag
      end
      
      def check_ag
        if session.command('ag --modeshow')['Access Gateway mode is enabled.'].nil?
          abort("Access Gateway mode required to configure switch.")
        end
      end

      def login
        return if session.handles_login?
        if @session.user != ''
          session.command(@session.user, {:prompt => /^Password:/, :noop => false})
        else
          session.expect(/^Password:/)
        end
        session.command(@session.password, :noop => false)
      end

      def init_facts
        require 'puppet_x/iom_8x4/facts'
        @facts ||= PuppetX::Iom8x4::Facts.new(session)
        @facts.retrieve
      end

      def facts
        # This is here till we can fork Puppet
        facts = @facts.facts_to_hash
        # inject switch ip or fqdn info.
        #facts['fqdn'] = @url.host
        # inject manufacturer info.
        facts['Manufacturer'] = "Dell"
        facts
      end 
    end
  end
end
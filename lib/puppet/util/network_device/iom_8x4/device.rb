#This class is called by the puppet frame work for retrieving the facts .it  retrieve the facts and initialize the switch variables.
require 'puppet'
require 'puppet/util'
require 'puppet/util/network_device/base_ftos'
require 'puppet/util/network_device/iom_8x4/facts'
require 'puppet/util/network_device/dell_iom/model'
require 'puppet/util/network_device/dell_ftos/model'
require 'puppet/util/network_device/dell_iom/model/switch'
require 'puppet/util/network_device/iom_8x4'

class Puppet::Util::NetworkDevice::Iom_8x4::Device < Puppet::Util::NetworkDevice::Base_ftos

  attr_accessor :enable_password, :switch
  def initialize(url, options = {})
    super(url)
    @enable_password = options[:enable_password] || parse_enable(@url.query)
    @initialized = false
    transport.default_prompt = /[#>]\s?\z/n
  end

  def parse_enable(query)
    return $1 if query =~ /enable=(.*)/
  end

  def connect_transport
    transport.connect
    login
    check_ag
  end
  
  def check_ag
    if transport.command('ag --modeshow')['Access Gateway mode is enabled.'].nil?
      abort("Access Gateway mode required to configure switch.")
    end
  end

  def login
    return if transport.handles_login?
    if @transport.user != ''
      transport.command(@transport.user, {:prompt => /^Password:/, :noop => false})
    else
      transport.expect(/^Password:/)
    end
    transport.command(@transport.password, :noop => false)
  end

  def init
    unless @initialized
      connect_transport
      init_facts
      @initialized = true
    end
    return self
  end

  def init_facts
    @facts ||= Puppet::Util::NetworkDevice::Iom_8x4::Facts.new(transport)
    @facts.retrieve
  end

  def facts
    # This is here till we can fork Puppet
    init
    facts = @facts.facts_to_hash
    # inject switch ip or fqdn info.
    facts['fqdn'] = @url.host
    # inject manufacturer info.
    facts['Manufacturer'] = "Dell"
    facts
  end
end

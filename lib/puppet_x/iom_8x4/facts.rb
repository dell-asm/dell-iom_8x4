#Lookup class which helps in registering the facts and retrieving the fact values

require 'puppet_x/iom_8x4/dsl'
require 'puppet_x/iom_8x4/possible_facts'

module PuppetX
  module Iom8x4
    class Facts
      include PuppetX::Iom8x4::Dsl
      attr_reader :transport
      
      def initialize(transport)
        @transport = transport
      end

      def mod_path_base
        return 'puppet/util/network_device/iom_8x4/possible_facts'
      end

      def mod_const_base
        return PuppetX::Iom8x4::PossibleFacts
      end

      def param_class
        return PuppetX::Iom8x4::Fact
      end

      # TODO
      def facts
        @params
      end

      def facts_to_hash
        params_to_hash
      end
    end
  end
end

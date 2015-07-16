#The class has the base methods for parsing and keeping resource type(Like vlan, portchannel etc) valuesrequire 'puppet/util/network_device/iom_8x4/model'
module PuppetX
  module Iom8x4
    module Model
      class GenericValue
        attr_accessor :name, :transport, :facts, :idx, :value, :evaluated
        def initialize(name, transport, facts, idx, &block)
          @name = name
          @transport = transport
          @facts = facts
          @idx = idx
          self.instance_eval(&block) if block_given?
        end

        def default(value)
          @value ||= value
        end

        define_value_method [:cmd, :match, :add, :remove, :idx, :before, :after]

        # This is a Helper Method so we can make sure we are in the right scope
        def evaluate(&block)
          instance_eval(&block)
        end

        def parse(txt)
          if self.match.is_a?(Proc)
            self.value = self.match.call(txt)
          else
            self.value = txt.scan(self.match).flatten[self.idx]
          end
          self.evaluated = true
        end

        def update(transport, old_value)
          if self.value == :absent || self.value.nil?
            self.remove.call(transport, old_value)
            return
          end
          if self.value == :present
            self.add.call(transport, self.value)
            return
          end
          # Remove old Entrys
          ([old_value].flatten - [self.value].flatten).compact.each do |val|
            self.remove.call(transport, val)
          end
          # Add new Entrys
          ([self.value].flatten - [old_value].flatten).compact.each do |val|
            self.add.call(transport, val)
          end
        end

        def define_value_method(methods)
          methods.each do |meth|
            define_method(meth) do |*args, &block|
              # return the current value if we are called like an accessor
              return instance_variable_get("@#{meth}".to_sym) if args.empty? && block.nil?
              # set the new value if there is any
              instance_variable_set("@#{meth}".to_sym, (block.nil? ? args.first : block))
            end
          end
        end
      end
    end
  end
end
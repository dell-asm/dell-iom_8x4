#The class has the methods for parsing and keeping resource type(Like vlan, portchannel etc) values 
module PuppetX
  module Iom8x4
    module Model
      class ModelValue < PuppetX::Iom_8x4::Model::GenericValue
        def model(*args, &block)
          return @model if args.empty? && block.nil?
          @model = (block.nil? ? args.first : block)
        end

        def parse(txt)
          if self.match.is_a?(Proc)
            self.value = self.match.call(txt)
          else
            self.value = txt.scan(self.match).flatten.collect { |name| model.new(@transport, @facts, { :name => name } ) }
          end
          self.value ||= []
          self.evaluated = true
        end

        def update(transport, old_value)
        end
      end
    end
  end
end


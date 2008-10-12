module Rattl::Actions
	class ReplaceAttribute < Base
	
		def process
			each_element do |element|
				trigger_attr_value = element.attributes[trigger_attribute]
				target_attribute, var_name = trigger_attr_value.split('=')
				
				element.raw_attributes[target_attribute] = variable_store.get(var_name) || ''
				element.remove_attribute(trigger_attribute)
			end
			hdoc
		end
	
		def clean
			each_element do |element|
				element.remove_attribute(trigger_attribute)
			end
			hdoc
		end
	
		def each_element
			hdoc.search("//*[@#{trigger_attribute}]").each do |element|
				yield element
			end
		end
		
		private
		
			def trigger_attribute
				'rattl_replace_attr'
			end

	end
end

Rattl::ActionStore.register_action(Rattl::Actions::ReplaceAttribute)
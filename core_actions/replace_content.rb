module Rattl::Actions
	class ReplaceContent < Base
	
		def process
			each_element do |element|
				var_name = element.attributes[trigger_attribute]
				element.inner_html = variable_store.get(var_name)
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
				'rattl_replace_content'
			end

	end
end

Rattl::ActionStore.register_action(Rattl::Actions::ReplaceContent)
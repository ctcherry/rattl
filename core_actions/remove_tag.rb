module Rattl::Actions
	class RemoveTag < Base
	
		def process
			each_element do |element|
				element.swap('')
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
				'rattl_remove_tag'
			end

	end
end

Rattl::ActionStore.register_action(Rattl::Actions::RemoveTag)
module Rattl::Actions
	class For < Base
	
		def process
			each_element do |element|
				trigger_attr_value = element.attributes[trigger_attribute]
				collection_variable_name, single_item = trigger_attr_value.split(':')
				
				element.remove_attribute(trigger_attribute)
				partial_source = element.to_html

				template_parts = variable_store.get(collection_variable_name).collect do |hash_piece|
					partial_template_variables = variable_store.variable_hash.dup
					partial_template_variables.merge!(single_item.to_sym => hash_piece)

					partial_template = Rattl::Template.new(partial_source)
					partial_template.render(partial_template_variables)
				end
				final_result = template_parts.join("\n")
				element.swap(final_result)
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
				'rattl_for'
			end

	end
end

Rattl::ActionStore.register_action(Rattl::Actions::For)
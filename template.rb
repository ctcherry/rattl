module Rattl
	
	class Template
		
		attr_reader :variables
		attr_reader :source
		
		def initialize(source)
			@source = source
			@variables = {}
		end
		
		def render(hash = {})
			@variables = hash
			parse
			hdoc.to_html
		end
		
		def clean
			parse(:clean)
			hdoc.to_html
		end
		
		private
		
			def parse(action = :process)
				Rattl::ActionStore.available_actions.each do |action_class|
					action_class.new(hdoc, @variables).send(action)
				end
			end
			
			def hdoc
				@hdoc ||= Hpricot(@source)
			end
			
	end

end
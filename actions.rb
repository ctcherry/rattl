module Rattl
	module Actions
		
		class Base
			
			attr_reader :hdoc
			attr_reader :template_variables
			
			def initialize(hdoc, template_hash)
				@hdoc = hdoc
				@template_variables = template_hash
			end
			
			def process
				raise NotImplementedError, "You must specify the `process` method on a subclass of Rattl::Actions::Base"
			end
			
			def clean
				raise NotImplementedError, "You must specify the `clean` method on a subclass of Rattl::Actions::Base"
			end
		
		end
		
	end
end

# Require all action files
Dir[File.join(File.dirname(__FILE__), "actions/*.rb")].each { |f| require f }
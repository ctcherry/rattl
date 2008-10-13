module Rattl
	module Actions
		
		class Base
			
			attr_reader :hdoc
			attr_reader :variable_store
			
			def initialize(hdoc, variable_hash)
				@hdoc = hdoc
				@variable_store = VariableStore.new(variable_hash)
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

# Require core_action files in order of operation

require 'core_actions/for'
require 'core_actions/remove_tag'
require 'core_actions/if'
require 'core_actions/replace_tag'
require 'core_actions/replace_content'
require 'core_actions/replace_attribute'

# Require all other extra_action files
Dir[File.join(File.dirname(__FILE__), "extra_actions/*.rb")].each { |f| require f }
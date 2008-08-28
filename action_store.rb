module Rattl

	class ActionStore
		
		def self.available_actions
			@actions
		end

		def self.register_action(klass)
			@actions = [] if @actions.nil?
			@actions << klass unless @actions.include? klass
		end
		
	end

end
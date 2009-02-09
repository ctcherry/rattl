module Rattl

	class ActionStore
		
		def self.available_actions
			@actions ||= []
		end

		def self.register_action(klass)
			self.available_actions << klass unless self.available_actions.include? klass
		end
		
	end

end
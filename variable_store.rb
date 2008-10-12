module Rattl
	
	class VariableStore
	
		attr_accessor :variable_hash
	
		def initialize(nested_hash = {})
			self.variable_hash = Hash.new(Hash.new(Hash.new))
			self.variable_hash.merge!(nested_hash)
		end
		
		def get(template_variable_name, scope = nil)
			scope = variable_hash if scope.nil?
			
			variable_path = template_variable_name.split('.')
			if variable_path.size == 1
				return scope[template_variable_name.to_sym] if scope.has_key?(template_variable_name.to_sym)
				return nil
			end
			
			return get(variable_path[1..-1].join('.'), scope[variable_path.first.to_sym])
		end
		
	end
	
end
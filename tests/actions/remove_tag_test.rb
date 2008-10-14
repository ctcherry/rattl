require File.dirname(__FILE__) + '/../rattl_test_helper'

class RemoveTagTest < Test::Unit::TestCase
	
	def setup
		@action_class = Rattl::Actions::RemoveTag
		@hdoc = Hpricot(template_source)
	end
	
	def test_should_remove_tag_with_template_variable
		assert template_source.include?('<div rattl_remove_tag>Hello my name is John Smith</div>')
		
		@action_class.new(@hdoc, {:testvar => 'Chris Cherry'}).process
		result = @hdoc.to_html
		
		assert !result.include?('Hello my name is John Smith')
	end
	
	def test_should_template_attribute_on_clean
		assert template_source.include?('<div rattl_remove_tag>Hello my name is John Smith</div>')
		
		@action_class.new(@hdoc, {:testvar => 'Chris Cherry'}).clean
		result = @hdoc.to_html

		assert result.include?('<div>Hello my name is John Smith</div>')
	end
	
	private
	
		def template_source
			<<-HTML
			<html>
			<body>
				<div rattl_remove_tag>Hello my name is John Smith</div>
			</body>
			</html>
			HTML
		end
	
end
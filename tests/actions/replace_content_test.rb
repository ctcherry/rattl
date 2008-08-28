require '../rattl_test_helper'

class ReplaceContentTest < Test::Unit::TestCase
	
	attr_reader :action_class, :hdoc
	
	def setup
		@action_class = Rattl::Actions::ReplaceContent
		@hdoc = Hpricot(template_source)
	end
	
	def test_should_replace_content_with_template_variable
		assert template_source.include?('Default sample content')
		
		action_class.new(hdoc, {:testvar => 'cool content'}).process
		result = hdoc.to_html
		
		assert result.include?('cool content')
	end
	
	def test_should_remove_trigger_attribute_on_process
		assert template_source.include?('rattl_replace_content="testvar"')
		
		action_class.new(hdoc, {:testvar => 'cool content'}).process
		result = hdoc.to_html
		
		assert !result.include?('rattl_replace_content="testvar"')
	end
	
	def test_should_remove_trigger_attribute_on_clean_and_leave_sample_content
		assert template_source.include?('<div rattl_replace_content="testvar">Default sample content</div>')
		
		action_class.new(hdoc, {:testvar => 'cool content'}).clean
		result = hdoc.to_html
		
		assert result.include?('<div>Default sample content</div>')
	end
	
	private
	
		def template_source
			<<-HTML
			<html>
			<body>
				<div rattl_replace_content="testvar">Default sample content</div>
			</body>
			</html>
			HTML
		end
	
end
require File.dirname(__FILE__) + '/../rattl_test_helper'

class ReplaceAttributeTest < Test::Unit::TestCase
	
	def setup
		@action_class = Rattl::Actions::ReplaceAttribute
		@hdoc = Hpricot(template_source)
	end
	
	def test_should_replace_attribute_with_template_variable
		assert template_source.include?('http://google.com')
		
		@action_class.new(@hdoc, {:link_url => 'http://yahoo.com'}).process
		result = @hdoc.to_html
		
		assert result.include?('http://yahoo.com')
	end
	
	def test_should_remove_trigger_attribute_on_process
		assert template_source.include?('rattl_replace_attr="href=link_url"')
		
		@action_class.new(@hdoc, {:link_url => 'http://yahoo.com'}).process
		result = @hdoc.to_html
		
		assert !result.include?('rattl_replace_attr="href=link_url"')
	end
	
	def test_should_remove_trigger_attribute_on_clean_and_leave_sample_content
		assert template_source.include?('<a rattl_replace_attr="href=link_url" href="http://google.com">Google</a>')
		
		@action_class.new(@hdoc, {:link_url => 'http://yahoo.com'}).clean
		result = @hdoc.to_html
		
		assert result.include?('<a href="http://google.com">Google</a>')
	end
	
	private
	
		def template_source
			<<-HTML
			<html>
			<body>
				<a rattl_replace_attr="href=link_url" href="http://google.com">Google</a>
			</body>
			</html>
			HTML
		end
	
end
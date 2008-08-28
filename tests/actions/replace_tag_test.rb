require '../rattl_test_helper'

class ReplaceContentTest < Test::Unit::TestCase
	
	attr_reader :action_class, :hdoc
	
	def setup
		@action_class = Rattl::Actions::ReplaceTag
		@hdoc = Hpricot(template_source)
	end
	
	def test_should_replace_tag_with_template_variable
		assert template_source.include?('<span rattl_replace_tag="testvar">John Smith</spa')
		assert !template_source.include?('Chris Cherry')
		
		action_class.new(hdoc, {:testvar => 'Chris Cherry'}).process
		result = hdoc.to_html
		
		assert result.include?('Chris Cherry')
	end
	
	def test_should_remove_trigger_attribute_on_process
		assert template_source.include?('rattl_replace_tag="testvar"')
		
		action_class.new(hdoc, {:testvar => 'Chris Cherry'}).process
		result = hdoc.to_html
		
		assert !result.include?('rattl_replace_tag="testvar"')
	end
	
	def test_should_remove_tag_and_leave_sample_content_on_clean
		assert template_source.include?('<div>Hello my name is <span rattl_replace_tag="testvar">John Smith</span></div>')
		
		action_class.new(hdoc, {:testvar => 'Chris Cherry'}).clean
		result = hdoc.to_html
		
		assert result.include?('<div>Hello my name is John Smith</div>')
	end
	
	private
	
		def template_source
			<<-HTML
			<html>
			<body>
				<div>Hello my name is <span rattl_replace_tag="testvar">John Smith</span></div>
			</body>
			</html>
			HTML
		end
	
end
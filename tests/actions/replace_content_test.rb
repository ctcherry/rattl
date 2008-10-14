require File.dirname(__FILE__) + '/../rattl_test_helper'

class ReplaceContentTest < Test::Unit::TestCase

	def setup
		@action_class = Rattl::Actions::ReplaceContent
		@hdoc = Hpricot(template_source)
	end
	
	def test_should_replace_content_with_template_variable
		assert template_source.include?('Default sample content')
		
		@action_class.new(@hdoc, template_hash).process
		result = @hdoc.to_html
		
		assert result.include?('cool content')
	end
	
	def test_should_replace_content_with_template_variable_nested_with_dot
		assert template_source_nested.include?('Default sample content')
		@hdoc = Hpricot(template_source_nested)
		
		@action_class.new(@hdoc, template_hash).process
		result = @hdoc.to_html
		
		assert result.include?('Chris')
	end
	
	def test_should_remove_trigger_attribute_on_process
		assert template_source.include?('rattl_replace_content="testvar"')
		
		@action_class.new(@hdoc, template_hash).process
		result = @hdoc.to_html
		
		assert !result.include?('rattl_replace_content="testvar"')
	end
	
	def test_should_remove_trigger_attribute_on_clean_and_leave_sample_content
		assert template_source.include?('<div rattl_replace_content="testvar">Default sample content</div>')
		
		@action_class.new(@hdoc, template_hash).clean
		result = @hdoc.to_html

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
		
		def template_source_nested
			<<-HTML
				<div rattl_replace_content="author.name">Default sample content</div>
			HTML
		end
		
		def template_hash
			{ :testvar => 'cool content',
			  :author => { :name => 'Chris'} }
		end
	
end
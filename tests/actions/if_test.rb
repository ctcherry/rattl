require '../rattl_test_helper'

class IfTest < Test::Unit::TestCase
	
	attr_reader :action_class, :hdoc
	
	def setup
		@action_class = Rattl::Actions::If
		@hdoc = Hpricot(template_source)
	end
	
	def test_should_remove_tag_if_template_varialbe_is_false
		assert template_source.include?('<div rattl_if="show_user_data">')
		assert template_source.include?('Chris')
		assert template_source.include?('ctcherry@gmail.com')
		
		action_class.new(hdoc, {:show_user_data => false}).process
		result = hdoc.to_html
		
		assert !result.include?('<div rattl_if="show_user_data">')
		assert !result.include?('Chris')
		assert !result.include?('ctcherry@gmail.com')
	end
	
	def test_should_keep_tag_if_template_variable_is_true
		assert template_source.include?('Chris')
		assert template_source.include?('ctcherry@gmail.com')
		
		action_class.new(hdoc, {:show_user_data => true}).process
		result = hdoc.to_html
		
		assert result.include?('Chris')
		assert result.include?('ctcherry@gmail.com')
	end
	
	def test_should_remove_trigger_attribute_if_keeping_tag
		assert template_source.include?('<div rattl_if="show_user_data">')
		
		action_class.new(hdoc, {:show_user_data => true}).process
		result = hdoc.to_html
		
		assert result.include?('<div>')
		assert !result.include?('rattl_if="show_user_data"')
	end
	
	def test_should_remove_trigger_attribute_on_clean
		assert template_source.include?('<div rattl_if="show_user_data">')
		
		action_class.new(hdoc, {:show_user_data => true}).clean
		result = hdoc.to_html
		
		assert result.include?('<div>')
		assert !result.include?('rattl_if="show_user_data"')
	end
	
	private
	
		def template_source
			<<-HTML
			<html>	
			<body>
				<div rattl_if="show_user_data">
					<span>Chris</span>
					<span>ctcherry@gmail.com</span>
				</div>
			</body>
			</html>
			HTML
		end
	
end
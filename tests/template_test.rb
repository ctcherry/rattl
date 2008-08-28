require 'rattl_test_helper'

class TemplateTest < Test::Unit::TestCase
	
	def test_should_make_new_template_with_source
		@template = Rattl::Template.new(template_source)
		
		assert @template.is_a?(Rattl::Template)
	end
	
	def test_should_be_able_to_access_source
		@template = Rattl::Template.new(template_source)
		
		assert_equal template_source, @template.source
	end
	
	def test_should_render_with_variables_replaced
		@template = Rattl::Template.new(template_source)
		
		result = @template.render(template_variables)
		assert_equal template_expected, result
	end
	
	private
	
		def template_variables
			{ :content => "Cool test replacement content", :author_name => "Chris Cherry"}
		end
	
		def template_source
			<<-HTML
			<html>
			<body>
				<div rattl_replace_content="content">Default sample content</div>
				<div>
					<p>Hello my name is <span rattl_replace_tag="author_name">John Smith</span></p>
				</div>
			</body>
			</html>
			HTML
		end
		
		def template_expected
			<<-HTML
			<html>
			<body>
				<div>Cool test replacement content</div>
				<div>
					<p>Hello my name is Chris Cherry</p>
				</div>
			</body>
			</html>
			HTML
		end
	
end
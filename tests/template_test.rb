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
		assert_equal template_expected_processed, result
	end
	
	def test_should_render_cleaned
		@template = Rattl::Template.new(template_source)
		
		result = @template.clean
		assert_equal template_expected_cleaned, result
	end
	
	private
	
		def template_variables
			{ :content => "Cool test replacement content", :author_name => "Chris Cherry", :show_user_data => true, :link_url => 'http://yahoo.com', :items => [ {:name => 'Item1'}, {:name => 'Item2'} ] }
		end
	
		def template_source
			<<-HTML
			<html>
			<body>
				<div rattl_replace_content="content">Default sample content</div>
				<div>
					<p>Hello my name is <span rattl_replace_tag="author_name">John Smith</span></p>
				</div>
				<div rattl_if="show_user_data">
					<span>Chris Cherry ctcherry@gmail.com</span>
				</div>
				<ul>
					<li rattl_for="items:item" rattl_replace_content="item.name">Item</li>
				</ul>
				<div rattl_remove_tag>Removed!</div>
				<a rattl_replace_attr="href=link_url" href="http://google.com">Search Engine</a>
			</body>
			</html>
			HTML
		end
		
		def template_expected_processed
			<<-HTML
			<html>
			<body>
				<div>Cool test replacement content</div>
				<div>
					<p>Hello my name is Chris Cherry</p>
				</div>
				<div>
					<span>Chris Cherry ctcherry@gmail.com</span>
				</div>
				<ul>
					<li>Item1</li>
<li>Item2</li>
				</ul>
				
				<a href="http://yahoo.com">Search Engine</a>
			</body>
			</html>
			HTML
		end
		
		def template_expected_cleaned
			<<-HTML
			<html>
			<body>
				<div>Default sample content</div>
				<div>
					<p>Hello my name is John Smith</p>
				</div>
				<div>
					<span>Chris Cherry ctcherry@gmail.com</span>
				</div>
				<ul>
					<li>Item</li>
				</ul>
				<div>Removed!</div>
				<a href="http://google.com">Search Engine</a>
			</body>
			</html>
			HTML
		end
	
end
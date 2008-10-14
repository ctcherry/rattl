require File.dirname(__FILE__) + '/../rattl_test_helper'

class ForTest < Test::Unit::TestCase
	
	def setup
		@action_class = Rattl::Actions::For
		@hdoc = Hpricot(template_source)
	end
	
	def test_should_replace_tag_with_template_variables_in_a_loop
		assert template_source.include?('<li rattl_for="items:item" rattl_replace_attr="title=title">Menu Item: <span rattl_replace_tag="item.name">First Item</span></li>')
		assert !template_source.include?('<li>Menu1</li>')
		assert !template_source.include?('<li>Menu2</li>')
		
		@action_class.new(@hdoc, items_hash).process
		result = @hdoc.to_html

		assert result.include?('<li title="My Title">Menu Item: Menu1</li>')
		assert result.include?('<li title="My Title">Menu Item: Menu2</li>')
	end
	
	def test_should_replace_tag_with_template_variables_nested
		assert template_source_nested.include?('<div rattl_for="authors:author">')
		assert template_source_nested.include?('<li rattl_for="author.books:book" rattl_replace_content="book.title">Some Book</li>')
		
		@hdoc = Hpricot(template_source_nested)
		@action_class.new(@hdoc, items_hash).process
		result = @hdoc.to_html

		assert result.include?('<p>Chris</p>')
		assert result.include?('<li>Book1</li>')
		assert result.include?('<li>Book2</li>')
		assert result.include?('<p>Sean</p>')
		assert result.include?('<li>Book3</li>')
		assert result.include?('<li>Book4</li>')
	end
	
	def test_should_remove_trigger_attribute_on_clean
		assert template_source.include?('<li rattl_for="items:item" rattl_replace_attr="title=title">Menu Item: <span rattl_replace_tag="item.name">First Item</span></li>')
		
		@action_class.new(@hdoc, {}).clean
		result = @hdoc.to_html
		
		assert result.include?('<li rattl_replace_attr="title=title">Menu Item: <span rattl_replace_tag="item.name">First Item</span></li>')
		assert !result.include?('rattl_for=')
	end
	
	private
	
		def template_source
			<<-HTML
			<html>
			<body>
				<ul>
					<li rattl_for="items:item" rattl_replace_attr="title=title">Menu Item: <span rattl_replace_tag="item.name">First Item</span></li>
				</ul>
			</body>
			</html>
			HTML
		end
		
		def template_source_nested
			<<-HTML
			<html>
			<body>
				<div rattl_for="authors:author">
					<p rattl_replace_content="author.name">Joe</p>
					<ul>
						<li rattl_for="author.books:book" rattl_replace_content="book.title">Some Book</li>
					</ul>
				</div>
			</body>
			</html>
			HTML
		end
		
		def items_hash
			{ :items => [ {:name => 'Menu1'}, {:name => 'Menu2'} ],
			  :title => "My Title",
			  :authors => [
			    { :name => 'Chris',
			      :books => [ {:title => 'Book1'}, {:title => 'Book2'} ] },
			    { :name => 'Sean',
			      :books => [ {:title => 'Book3'}, {:title => 'Book4'} ] }
				]
			}
		end
	
end
require File.dirname(__FILE__) + '/rattl_test_helper'

class VariableStoreTest < Test::Unit::TestCase
	
	def setup
		@variable_store = Rattl::VariableStore.new(nested_hash)
	end
	
	def test_should_create_store
		assert @variable_store
	end
	
	def test_should_get_simple_variable
		value = @variable_store.get('title')
		assert_equal 'A Book', value
	end
	
	def test_should_return_hash_if_thats_what_the_variable_is
		value = @variable_store.get('author')
		assert value.is_a?(Hash)
		assert_equal 'Chris', value[:first_name]
	end
	
	def test_should_dig_into_hash_to_get_variable_using_dot_method
		value = @variable_store.get('author.age')
		assert_equal 21, value
	end
	
	def test_should_dig_into_hash_to_get_variable_using_dot_method_twice
		value = @variable_store.get('author.address.city')
		assert_equal 'San Diego', value
	end
	
	def test_should_dig_into_hash_to_get_variable_using_dot_method_three_times
		value = @variable_store.get('author.address.state.name')
		assert_equal 'California', value
	end
	
	def test_should_get_nil_if_attribute_doesnt_exist
		value = @variable_store.get('author.location')
		assert_equal nil, value
	end
	
	private
	
		def nested_hash
			{ :title => "A Book",
			  :author => {
			    :first_name => 'Chris',
			    :last_name => 'Cherry',
			    :age => 21, 
			    :address => {
			      :street => '123 Street Rd.',
			      :city => 'San Diego',
			      :state => {
			        :name => 'California',
			        :code => 'CA'
			      }, 
			    :zip => 90000
			    }
			  } 
			}
		end
	
end
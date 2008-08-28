require 'rubygems'
require 'hpricot'

$: << File.expand_path(File.dirname(__FILE__))

require 'template'
require 'action_store'
require 'actions'

module Rattl; end


# puts Rattl::ActionStore.available_actions.inspect
# 
# template_source = File.new("simple.rattl").read
# 
# temp = Rattl::Template.new(template_source)
# 
# simple_template_variables = {
# 	:title => 'this title should be in the title bar',
# 	:page_title => 'This is my super cool page title',
# 	:description => "Welcome to my super awesome webpage! Here you will learn about Rattl (Ruby Attribute Tag Lagnauge) and what it can do for you.",
# 	:author_name => "Chris Cherry"
# }
# 
# puts temp.render(simple_template_variables).inspect
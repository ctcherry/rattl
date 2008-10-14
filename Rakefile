require 'rake/testtask'

Rake::TestTask.new do |t|
	#t.libs << File.join(File.dirname(__FILE__), 'tests')
	t.test_files = FileList['tests/**/*_test.rb']
	t.verbose = true
end

task :default => [:test]
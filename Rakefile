begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require "rake/extensiontask"
require 'rake/testtask'

Rake::ExtensionTask.new "isbn_check" do |ext|
  ext.lib_dir = "lib/isbn_extractor/isbn_check"
end

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

task default: :test
task spec: :test

Bundler::GemHelper.install_tasks

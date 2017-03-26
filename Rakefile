# frozen_string_literal: true

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

require "rake"
require "rake/extensiontask"
require "rake/testtask"
require "rubocop/rake_task"

Rake::ExtensionTask.new "isbn_check" do |ext|
  ext.lib_dir = "lib/isbn_extractor/isbn_check"
end

Rake::TestTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.libs << "spec"
  t.warning = false
end

RuboCop::RakeTask.new

task default: %i[rubocop test]
task spec: :test

Bundler::GemHelper.install_tasks

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r isbn_extractor.rb"
end

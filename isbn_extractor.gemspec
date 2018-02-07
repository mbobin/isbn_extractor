# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require "isbn_extractor/version"

Gem::Specification.new do |s|
  s.name        = "isbn_extractor"
  s.version     = ISBNExtractor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Marius Bobin"]
  s.email       = ["marius.bobin@gmail.com"]
  s.homepage    = "https://github.com/mgb313/isbn_extractor"
  s.summary     = "Extract ISBN from pdfs, epubs"
  s.description = "Extract valid ISBN from pdfs, epubs"
  s.license     = "MIT"

  s.files = Dir["lib/**/*", "Rakefile"]
  s.extensions = %w[ext/isbn_check/extconf.rb]

  s.add_dependency "pdf-reader", "~> 2.0"
  s.add_dependency "epub-parser", "~> 0.2", ">= 0.2.6"
  s.add_dependency "henkei", "~> 1.14", ">= 1.14.3"
  s.add_dependency "concurrent-ruby", "~> 1.0", ">= 1.0.2"
  s.add_dependency "mime-types"

  s.add_development_dependency "minitest", "~> 5.9"
  s.add_development_dependency "minitest-reporters", "~> 1.1"
  s.add_development_dependency "rake", "~> 11.2"
  s.add_development_dependency "rake-compiler", "~> 1.0"
  s.add_development_dependency "rubocop", "~> 0.48.1"
end

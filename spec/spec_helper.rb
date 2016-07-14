require 'minitest/autorun'
require 'minitest/reporters'
require 'isbn_extractor'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

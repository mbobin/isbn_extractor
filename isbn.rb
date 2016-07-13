require 'pdf-reader'
require 'epub/parser'
require 'logger'
require 'json'
require 'thread'
require 'concurrent'
require_relative 'lib/regexps'
require_relative 'lib/errors'
require_relative 'lib/readers/null_reader'
require_relative 'lib/reader'
require_relative 'lib/readers/pdf_reader'
require_relative 'lib/readers/epub_reader'
require_relative 'lib/finder'

module ISBN
  def self.process directory, output = nil
    Finder.new(directory: directory, output: output).parse
  end
end

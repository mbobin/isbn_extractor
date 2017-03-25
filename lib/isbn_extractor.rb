# frozen_string_literal: true

require "thread"
require "pathname"
require "pdf-reader"
require "epub/parser"
require "concurrent"
require_relative "isbn_extractor/regexps"
require_relative "isbn_extractor/errors"
require_relative "isbn_extractor/isbn_check"
require_relative "isbn_extractor/readers/null_reader"
require_relative "isbn_extractor/reader"
require_relative "isbn_extractor/readers/pdf_reader"
require_relative "isbn_extractor/readers/epub_reader"
require_relative "isbn_extractor/finder"

module ISBNExtractor
  def self.process(directory, output = nil)
    Finder.new(directory: directory, output: output).parse
  end
end

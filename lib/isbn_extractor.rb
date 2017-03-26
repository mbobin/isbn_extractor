# frozen_string_literal: true

require "thread"
require "pathname"
require "pdf-reader"
require "epub/parser"
require "concurrent"
require_relative "isbn_extractor/regexps"
require_relative "isbn_extractor/errors"
require_relative "isbn_extractor/isbn_check"
require_relative "isbn_extractor/readers/base"
require_relative "isbn_extractor/readers/null_reader"
require_relative "isbn_extractor/readers/pdf_reader"
require_relative "isbn_extractor/readers/epub_reader"
require_relative "isbn_extractor/readers/string_reader"
require_relative "isbn_extractor/file_reader"
require_relative "isbn_extractor/directory"

module ISBNExtractor
  class << self
    def process_directory(directory, output_path = nil)
      Directory.new(path: directory, output_path: output_path).call
    end

    def process_text(data)
      Readers::StringReader.new(data).isbn
    end
  end
end

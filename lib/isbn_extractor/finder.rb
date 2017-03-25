# frozen_string_literal: true

module ISBNExtractor
  class Finder
    def initialize(directory:, output: nil)
      @directory = directory
      @output = output
    end

    def parse
      parse_result
      write_to_output
      parse_result
    end

    protected

    def concurrent(path)
      Concurrent::Future.execute do
        reader = Reader.new(path)
        { book: { path: path, isbn: reader.isbn } }
      end
    end

    def pattern
      return @directory if @directory.end_with?(".pdf", ".epub")
      Pathname(@directory).join("**", "**", "*.{pdf,epub}")
    end

    def parse_result
      @parse_result ||= Dir.glob(pattern)
                           .map(&method(:concurrent))
                           .map(&:value).compact
    end

    def write_to_output
      return unless @output
      File.open(@output, "w+") { |f| f.write parse_result }
    end
  end
end

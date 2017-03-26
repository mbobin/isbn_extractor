# frozen_string_literal: true

module ISBNExtractor
  class Directory
    def initialize(path:, output_path: nil)
      @path = path
      @output_path = output_path
    end

    def call
      gather_data
      write_to_file
      @data
    end

    protected

    def concurrent(path)
      Concurrent::Future.execute do
        { path: path, isbn: FileReader.new(path).isbn }
      end
    end

    def pattern
      if @path.end_with?(".pdf", ".epub")
        @path
      else
        Pathname(@path).join("**", "*.{pdf,epub}")
      end
    end

    def gather_data
      @data ||= Dir.glob(pattern)
                   .map(&method(:concurrent))
                   .map(&:value)
                   .compact
    end

    def write_to_file
      return unless @output_path
      File.open(@output_path, "w+") { |f| f.write gather_data }
    end
  end
end

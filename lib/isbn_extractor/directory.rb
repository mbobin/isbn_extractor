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

    module PureRubyDirectory
      module_function

      def isbn(path)
        common = MIME::Types.of(path).map(&:preferred_extension) & extensions
        return unless common.any?

        FileReader.new(path).isbn
      end

      def extensions
        %w[pdf epub]
      end
    end

    module TikaDirectory
      module_function

      def isbn(path)
        common = MIME::Types.of(path).map(&:preferred_extension) & extensions
        return unless common.any?

        data = File.read(path)
        text = Henkei.read(:text, data)
        Readers::StringReader.new(text).isbn
      end

      def extensions
        %w[pdf epub doc docx rtf]
      end
    end

    def engine_module
      @engine_module ||= if ISBNExtractor.engine == :tika
        TikaDirectory
      else
        PureRubyDirectory
      end
    end

    def concurrent(path)
      Concurrent::Future.execute do
        { path: path, isbn: engine_module.isbn(path) }
      end
    end

    def pattern
      Pathname(@path.gsub(file_regexp, ""))
        .join("**", "*.{#{file_types}}")
    end

    def file_regexp
      engine_module
        .extensions
        .map { |ext| "\.#{ext}" }
        .join("|")
        .concat('\z')
    end

    def file_types
      engine_module.extensions.join(",")
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

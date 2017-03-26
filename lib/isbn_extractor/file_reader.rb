# frozen_string_literal: true

module ISBNExtractor
  class FileReader
    class << self
      def readers
        @readers ||= Hash.new(Readers::NullReader)
      end

      def register_reader(klass)
        readers[klass.reader_key] = klass
      end
    end

    register_reader Readers::PdfReader
    register_reader Readers::EpubReader

    def initialize(data)
      @data = data
      ext = @data.split(".").last.to_sym
      @reader = reader_klass(ext).new(data)
    end

    def reader_klass(ext)
      self.class.readers[ext]
    end

    def isbn
      @reader.isbn
    end
  end
end

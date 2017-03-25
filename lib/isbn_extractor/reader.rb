# frozen_string_literal: true

module ISBNExtractor
  class Reader
    class << self
      def readers
        @readers ||= Hash.new(NullReader)
      end

      def inherited(subclass)
        raise UnknownReaderError unless subclass.name.end_with?("Reader")

        readers[subclass.reader_key] = subclass
      end

      def reader_key
        name.match(/.*::(.*)Reader/).captures.first.to_s.downcase.to_sym
      end
    end

    def initialize(book)
      @book_path = book
      ext = @book_path.split(".").last.to_sym
      @reader = self.class.readers[ext].new(@book_path)
    end

    def isbn
      isbns.first
    end

    def isbns
      @isbns ||= @reader.extract_isbns
    end

    protected

    def regexps
      @regexps ||= Regexp.union(REGEXPS)
    end

    def parse_match(data)
      match = data.scrub.match(regexps)
      return [] unless match

      match
        .captures
        .compact
        .select { |string| ISBNCheck.valid? string.gsub!(/\W/, "") }
    end
  end
end

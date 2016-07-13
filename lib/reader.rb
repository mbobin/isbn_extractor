module ISBN
  class Reader
    class << self
      def readers
        @readers ||= Hash.new(NullReader)
      end

      def inherited subclass
        raise UnknownReaderError unless subclass.name.end_with?('Reader')

        readers[subclass.reader_key] = subclass
      end

      def reader_key
        name.match(/.*::(.*)Reader/).captures.first.to_s.downcase.to_sym
      end
    end

    def initialize book
      @book_path = book
      ext = @book_path.split(?.).last.to_sym
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

    def parse_match_data data
      puts data
      data.compact
        .map(&:captures)
        .flatten.compact
        .map(&:strip)
    rescue => e
      []
    end
  end
end

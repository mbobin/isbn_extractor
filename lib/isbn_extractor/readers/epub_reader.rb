# frozen_string_literal: true

module ISBNExtractor
  class EpubReader < Reader
    def initialize(path)
      @reader = EPUB::Parser.parse(path)
    end

    def extract_isbns
      return [meta_isbn] if meta_isbn?

      extract_from_content
    end

    protected

    def meta_isbn
      return unless meta_isbn?
      @reader.unique_identifier.content
    end

    def meta_isbn?
      @reader.unique_identifier.isbn?
    end

    def extract_from_content
      isbns = []
      @reader.each_content do |content|
        isbns.concat parse_match(content.read)
        break unless isbns.empty?
      end
      isbns
    end
  end
end

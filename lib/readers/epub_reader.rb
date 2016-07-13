module ISBN
  class EpubReader < Reader
    def initialize path
      @reader = EPUB::Parser.parse(path) rescue NullReader.new
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
        if match = content.read.scrub.match(regexps)
          isbns << match
          break
        end
      end
      parse_match_data isbns
    end
  end
end



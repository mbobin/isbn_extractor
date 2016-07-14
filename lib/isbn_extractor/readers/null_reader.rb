module ISBNExtractor
  class NullReader
    def initialize *args
    end

    def pages
      []
    end

    def extract_isbns
      []
    end
  end
end

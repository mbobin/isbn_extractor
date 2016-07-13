module ISBN
  class NullReader
    def initialize *args
    end

    def extract_isbns
      []
    end
  end
end

module ISBN
  class Finder
    def initialize directory:, output: nil
      @directory = directory
    end

    def parse
      Dir.glob(pattern)
        .map(&method(:concurrent))
        .map(&:value)
    end

    protected

    def concurrent path
      Concurrent::Future.execute do
        reader = Reader.new(path)
        { book: { path: path, isbn: reader.isbn } }
      end
    end

    def pattern
      Pathname(@directory).join('**','**', '*.{pdf,epub}')
    end
  end
end

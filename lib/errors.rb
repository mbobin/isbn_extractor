module ISBN
  class Error < StandardError; end
  class ReaderError < Error; end
  class UnknownReaderError < ReaderError; end
end

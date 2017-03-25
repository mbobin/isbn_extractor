# frozen_string_literal: true

module ISBNExtractor
  class Error < StandardError; end
  class ReaderError < Error; end
  class UnknownFile < Error; end
  class UnknownReaderError < ReaderError; end
end

# frozen_string_literal: true

module ISBNExtractor
  module Readers
    class StringReader < Base
      def initialize(text)
        @text = text
      end

      def isbns
        @isbns ||= parse_match(@text)
      end
    end
  end
end

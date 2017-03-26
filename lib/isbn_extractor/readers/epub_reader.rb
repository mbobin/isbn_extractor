# frozen_string_literal: true

module ISBNExtractor
  module Readers
    class EpubReader < Base
      def initialize(path)
        @reader = EPUB::Parser.parse(path)
      end

      def isbns
        @isbns ||= extract_isbns
      end

      protected

      def extract_isbns
        return [meta_isbn] if meta_isbn?

        extract_from_content
      end

      def meta_isbn
        @reader.unique_identifier.content
      end

      def meta_isbn?
        @reader.unique_identifier.isbn?
      end

      def extract_from_content
        data = []
        @reader.each_content do |content|
          data.concat parse_match(content.read)
          break unless data.empty?
        end
        data
      end
    end
  end
end

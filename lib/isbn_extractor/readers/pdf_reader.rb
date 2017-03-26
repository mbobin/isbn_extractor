# frozen_string_literal: true

module ISBNExtractor
  module Readers
    class PdfReader < Base
      def initialize(path)
        @reader = PDF::Reader.new(path)
      end

      def isbns
        @isbns ||= extract_isbns
      end

      protected

      def extract_isbns
        data = extract_isbn @reader.pages.first(10)
        data = extract_isbn @reader.pages.first(20).last(10) if data.empty?
        data = extract_isbn @reader.pages.last(30) if data.empty?
        data
      end

      def extract_isbn(pages)
        pages.collect { |page| parse_match(page.text) }.flatten
      end
    end
  end
end

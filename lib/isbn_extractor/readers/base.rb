# frozen_string_literal: true

module ISBNExtractor
  module Readers
    class Base
      def self.reader_key
        name.match(/.*::(.*)Reader/).captures.first.to_s.downcase.to_sym
      end

      def isbn
        isbns.first
      end

      def isbns
        []
      end

      protected

      def parse_match(data)
        match = data.scrub.match(ISBNExtractor::REGEXPS)
        return [] unless match

        match
          .captures
          .compact
          .select { |string| ISBNCheck.valid? string.gsub!(/\W/, "") }
      end
    end
  end
end

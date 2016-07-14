module ISBNExtractor
  REGEXPS = [
    /\bISBN\W?\s?([\d\-\sxX]{10,20})\b/,
    /\bISBN\W?\s?([\d\-\s]{13,20})\b/,
    /\bISBN-10\s?([\d\-\s]{10,15})\b/,
    /\bISBN-13\W?\s?([\d\-\s]{13,20})\b/,
    /\be-ISBN-13\W?\s?([\d\-\s]{13,20})\b/,
    /\bISBN-13\W?\s?\(pbk\)\W?\s?([\d\-\s]{13,20})\b/,
    /\bISBN-13\W?\s?\(electronic\)\W?\s?([\d\-\s]{13,20})\b/,
    /\b(\d{3}-\d{1}-\d{3}-\d{5}-\d{1})\b/
  ]
end

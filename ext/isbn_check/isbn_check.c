#include "ruby.h"

VALUE isbn_check = Qnil;

void Init_isbn_check();

VALUE method_valid(VALUE self, VALUE digits);
static int check_isbn_10(char *digits);
static int check_isbn_13(char *digits);
static int check_isbn(char *digits);

void
Init_isbn_check() {
  isbn_check = rb_define_module("ISBNCheck");
  rb_define_singleton_method(isbn_check, "valid?", method_valid, 1);
}

VALUE
method_valid(VALUE self, VALUE digits) {
  char *dig;

  Check_Type(digits, T_STRING);
  dig = rb_string_value_cstr(&digits);

  return check_isbn(dig) ? Qtrue : Qfalse;
}


static int
check_isbn_10(char *digits) {
  int i, s = 0, t = 0;

  for (i = 0; i < 9; i++) {
    t += digits[i] - '0';
    s += t;
  }

  if(digits[9] == 'X' || digits[9] == 'x') {
    t += 10;
  } else {
    t += digits[9] - '0';
  }
  s += t;

  return (s % 11 == 0);
}


static int
check_isbn_13(char *digits) {
  int i, s = 0;

  for (i = 0; i < 13; i++) {
    if(i % 2) {
      s += digits[i] * 3;
    } else {
      s += digits[i];
    }
  }

  return (s % 10 == 0);
}

static int
check_isbn(char *digits) {
  int length = strlen(digits);

  if(length == 10) {
    return check_isbn_10(digits);
  }

  if(length == 13) {
    return check_isbn_13(digits);
  }

  return 0;
}

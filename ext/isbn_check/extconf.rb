# frozen_string_literal: true

require "mkmf"

abort "missing strlen()" unless have_func "strlen"

create_makefile "isbn_check/isbn_check"

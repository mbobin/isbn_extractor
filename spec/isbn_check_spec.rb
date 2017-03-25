# frozen_string_literal: true

require "spec_helper"

describe ISBNCheck do
  describe "isbn 10" do
    it { ISBNCheck.valid?("020161622X").must_equal true }

    it { ISBNCheck.valid?("020161622x").must_equal true }

    it { ISBNCheck.valid?("9992158107").must_equal true }

    it { ISBNCheck.valid?("9992158104").must_equal false }

    it { ISBNCheck.valid?("020161623X").must_equal false }

    it { ISBNCheck.valid?("020161623x").must_equal false }
  end

  describe "isbn 13" do
    it { ISBNCheck.valid?("9788577807000").must_equal true }

    it { ISBNCheck.valid?("9788577807001").must_equal false }
  end

  describe "others" do
    it { ISBNCheck.valid?("chunky bacon").must_equal false }

    it { -> { ISBNCheck.valid?(123) }.must_raise TypeError }
  end
end

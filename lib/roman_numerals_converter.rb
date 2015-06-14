require_relative 'roman_reference'

class RomanNumeralsConverter
  include RomanReference

  attr_accessor :integers

  def initialize
    @integers = ''
  end

  def convert(obj)
    self.integers = convert_symbols_to_integers(obj.query.roman_numerals).reverse
    convert_roman_numerals_to_numbers
  end

private

  def convert_roman_numerals_to_numbers
    total = integers.first
    while integers.length > 1
      if integers[1] == nil
        total += integers[0]
      elsif integers[0] > integers[1]
        total -= integers[1]
      else
        total += integers[1]
      end
      integers.shift
    end
    total
  end
end

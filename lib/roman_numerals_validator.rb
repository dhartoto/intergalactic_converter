require_relative 'roman_reference'
require_relative 'roman_numerals'

class RomanNumeralsValidator
  include RomanReference

  attr_accessor :integer_array, :query, :symbol, :valid, :error_message

  def initialize
    self.valid = true
  end

  def validate(obj)
    set_instance_variables(obj)
    validate_roman_numerals
  end

  def valid?
    valid
  end

  private

  def set_instance_variables(obj)
    self.query = RomanNumerals.create(
      galactic_numerals: obj.query.galactic_numerals,
      note: obj.note
      )
    obj.query.roman_numerals = query
    self.integer_array = convert_symbols_to_integers(query)
  end

  def validate_roman_numerals
    error_message = "Input error: Check the order of your Intergalactic numerals"
    if repeat_more_than_three_times
      self.valid = false
      self.error_message = error_message
    elsif invalid_subtraction
      self.valid = false
      self.error_message = error_message
    elsif subtract_more_than_one_small_value
      self.valid = false
      self.error_message = error_message
    end
    self
  end

  def repeat_more_than_three_times
    query.include?('IIII') || query.include?("XXXX") || query.include?("MMMM")
  end

  def invalid_subtraction
    if integer_array.include?(10)
      resp = check(10)
      return true if resp == true
    end
    if integer_array.include?(50)
      resp = check(50)
      return true if resp == true
    end
    if integer_array.include?(100)
      resp = check(100)
      return true if resp == true
    end
    if integer_array.include?(500)
      resp = check(500)
      return true if resp == true
    end
    if integer_array.include?(1000)
      resp = check(1000)
      return true if resp == true
    end
    false
  end

  def subtract_more_than_one_small_value
    while integer_array.length >= 3
      return true if integer_array[0] < integer_array[2] || integer_array[1] < integer_array[2]
      integer_array.shift
    end
  end

  def check(nr)
    nr_index = integer_array.index(nr)
    unless nr_index == 0
      left_of_nr = integer_array[nr_index - 1]
      if left_of_nr < nr && left_of_nr == sym_constraints[nr]
        return false
      else
        return true
      end
    end
  end

  def sym_constraints
    @sym_constraints = {
      10 => 1, #X,I
      50 => 10, #L,X
      100 => 10, #C,X
      500 => 100, #D,C
      1000 => 100 #M,C
    }
  end

end

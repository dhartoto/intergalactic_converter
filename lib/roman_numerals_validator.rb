require_relative 'roman_reference'
require_relative 'roman_numerals'

class RomanNumeralsValidator
  include RomanReference

  attr_accessor :integers, :query, :symbol

  def initialize
    @query = ''
    @integers = ''
  end

  def validate(obj)
    set_instance_variables(obj)
    validate_roman_numerals
  end

  private

  def set_instance_variables(obj)
    self.query = RomanNumerals.create(
      ig_query: obj.ig_query,
      note: obj.note
      )
    obj.num_query = query
    self.integers = convert_symbols_to_integers(query)
  end

  Response = Struct.new(:valid?, :message)
  def validate_roman_numerals
    if valid?
      resp = Response.new(true, nil)
    else
      resp = Response.new(false, "Input error: Check the order of your Intergalactic numerals")
    end
  end

  def valid?
    if repeat_more_than_three_times
      false
    elsif invalid_subtraction
      false
    elsif subtract_more_than_one_small_value
      false
    else
      true
    end
  end

  def repeat_more_than_three_times
    query.include?('IIII') || query.include?("XXXX") || query.include?("MMMM")
  end

  def invalid_subtraction
    if integers.include?(10)
      resp = check(10)
      return true if resp == true
    end
    if integers.include?(50)
      resp = check(50)
      return true if resp == true
    end
    if integers.include?(100)
      resp = check(100)
      return true if resp == true
    end
    if integers.include?(500)
      resp = check(500)
      return true if resp == true
    end
    if integers.include?(1000)
      resp = check(1000)
      return true if resp == true
    end
    false
  end

  def subtract_more_than_one_small_value
    while integers.length >= 3
      return true if integers[0] < integers[2] || integers[1] < integers[2]
      integers.shift
    end
  end

  def check(nr)
    nr_index = integers.index(nr)
    unless nr_index == 0
      left_of_nr = integers[nr_index - 1]
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

require_relative 'note'
require_relative 'materials_validator'
require_relative 'galactic_numerals_validator'
require_relative 'roman_numerals_validator'
require_relative 'roman_numerals_converter'
require_relative 'query'

class QueryEngine

  MATERIALS_VALUE = {
    'silver'   => 17,
    'gold'     => 14450,
    'iron'     => 195.5,
    'platinum' => 20
    }

  attr_accessor :type, :query, :validators
  attr_reader :materials_value, :note, :converter

  def initialize(input)
    @materials_value = MATERIALS_VALUE
    @note = load_note
    @type = input
    @query = Query.new(type: type)
    @validators = set_validators
    @converter = RomanNumeralsConverter.new
  end

  def run
    while not query.valid?
      request_user_input
      validate_query
    end
    convert_query
  end

  private

  def load_note
    file = Note.import
    if file.loaded?
      file.content
    else
      abort(file.error_message)
    end
  end

  def set_validators
    [MaterialsValidator.new, GalacticNumeralsValidator.new, RomanNumeralsValidator.new]
  end

  # Type 1: convert numerals only.
  # Type 2: convert numerals and calculate material value
  def request_user_input
    if type == '1'
      puts 'Type in Intergalactic numerals then press enter.'
      puts 'e.g. glob prok'
    else
      puts 'Type in Intergalactic numerals and material then press enter.'
      puts 'e.g. glob prok silver'
    end
    # store_intergalactic_query(input)
    user_input = gets.chomp.strip.downcase
    query.build(user_input)
  end

  def validate_query
    validators.each do |validator|
      resp = validator.validate(self)
      if not resp.valid?
        query.valid = false
        puts resp.error_message
        reset_validators
        break
      end
      query.valid = true
    end
  end

  def convert_query
    if type == '1'
      puts "#{query.galactic_numerals} is #{converter.convert(self)}"
    else
      puts material_calc_response
    end
  end

  def material_calc_response
    if query.galactic_numerals == ''
      "#{query.material.capitalize} is #{materials_value[query.material]} Credits."
    else
      "#{query.galactic_numerals} #{query.material.capitalize} is #{converter.convert(self) * materials_value[query.material]} Credits."
    end
  end

  def reset_validators
    self.validators = set_validators
  end

end

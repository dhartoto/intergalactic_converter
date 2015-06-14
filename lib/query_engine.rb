require_relative 'note'
require_relative 'galactic_numerals_validator'
require_relative 'roman_numerals_validator'
require_relative 'roman_numerals_converter'

class QueryEngine

  MATERIALS = {
    'silver'=>17,
    'gold'=>14450,
    'iron'=>195.5,
    'platinum'=>20
    }

  attr_accessor :num_query, :mat_query, :ig_query, :type
  attr_reader :materials, :note, :validators, :converter

  def initialize(input)
    @materials = MATERIALS
    @note = load_note
    @type = input
    @ig_query = ''
    @num_query = ''
    @mat_query = ''
    @validators = [GalacticNumeralsValidator.new, RomanNumeralsValidator.new]
    @converter = RomanNumeralsConverter.new
  end

  def run
    set_query
    validate_query
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

  # Type 1: convert numerals only.
  # Type 2: convert numerals and calculate material value
  def set_query
    if type == '1'
      puts 'Type in Intergalactic numerals then press enter.'
      puts 'e.g. glob prok'
      input = gets.chomp.strip.downcase
      store_intergalactic_query(input)
    else
      puts 'Type in Intergalactic numerals and material then press enter.'
      puts 'e.g. glob prok silver'
      input = gets.chomp.strip.downcase.split(' ')
      store_material(input)
      store_intergalactic_query(input)
    end
  end

  def store_material(input)
    self.mat_query = input.pop
  end

  def store_intergalactic_query(input)
    if type == '1'
      self.ig_query = input
    else
      self.ig_query = input.join(' ')
    end
  end

  def validate_query
    if type == '2'
      validate_material
    end
    validators.each do |validator|
      resp = validator.validate(self)
      if not resp.valid?
        puts resp.message
        run
      end
    end
  end

  def validate_material
    if not materials.keys.include?(mat_query)
      puts "Sorry we do not have a value for #{mat_query} at this time."
      puts 'Try: silver, gold or iron'
      run
    end
  end

  def convert_query
    if type == '1'
      puts "#{ig_query} is #{converter.convert(self)}"
    else
      puts material_calc_response
    end
  end

  def material_calc_response
    if ig_query == ''
      "#{mat_query.capitalize} is #{materials[mat_query]} Credits."
    else
      "#{ig_query} #{mat_query.capitalize} is #{converter.convert(self) * materials[mat_query]} Credits."
    end
  end

end

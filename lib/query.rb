class Query

  attr_accessor :valid, :material, :galactic_numerals, :roman_numerals
  attr_reader :type


  def initialize(options={})
    self.valid = false
    @type  = options[:type]
  end

  def build(input)
    if type == '1'
      self.galactic_numerals = input
    else
      input = input.split(' ')
      self.material = input.pop
      self.galactic_numerals = input.join(' ')
    end
  end

  def valid?
    valid
  end

end

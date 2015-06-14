class GalacticNumeralsValidator

  attr_accessor :query, :note

  def initialize
    @query = ''
    @note = ''
  end

  def validate(obj)
    self.query = obj.ig_query
    self.note = obj.note
    validate_galactic_numerals
  end

  private

  Response = Struct.new(:valid?, :message)

  def validate_galactic_numerals
    if valid?
      resp = Response.new(true, nil)
    else
      msg = "Input error: please check the spelling of your intergalactic numerals."
      resp = Response.new(false, msg)
    end
  end

  def valid?
    valid = true
    query.split(' ').each do |num|
      valid = false if not note.keys.include?(num)
    end
    valid
  end
end

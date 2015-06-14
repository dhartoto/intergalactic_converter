class GalacticNumeralsValidator

  attr_accessor :query, :note, :valid, :error_message

  def initialize
    self.valid = true
  end

  def validate(obj)
    self.query = obj.query.galactic_numerals
    self.note = obj.note
    validate_galactic_numerals
  end

  def valid?
    valid
  end

  private

  def validate_galactic_numerals
    query.split(' ').each do |num|
      if not note.keys.include?(num)
        self.valid = false
        self.error_message = "Input error: please check the spelling of your intergalactic numerals."
      end
    end
    self
  end

end

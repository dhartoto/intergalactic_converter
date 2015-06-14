class MaterialsValidator

  attr_accessor :valid, :query, :materials_value, :error_message

  def initialize
    self.valid = true
  end

  def validate(obj)
    self.query = obj.query.material
    self.materials_value = obj.materials_value
    obj.type == '2' ? validate_material : self
  end

  def valid?
    valid
  end

  private

  def validate_material
    if not materials_value.keys.include?(query)
      self.error_message = "Sorry we do not have a value for #{query} at this time."\
      "\nTry: silver, gold or iron"
      self.valid = false
    end
    self
  end

end

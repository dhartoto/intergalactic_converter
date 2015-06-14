module RomanReference

  def convert_symbols_to_integers(sym)
    integer_array = []
    sym.split('').each do |s|
      integer_array << reference_table(s)
    end
    integer_array
  end

  private

  def reference_table(sym)
    case sym
      when 'I'
        1
      when 'V'
        5
      when 'X'
        10
      when 'L'
        50
      when 'C'
        100
      when 'D'
        500
      when 'M'
        1000
    end
  end

end

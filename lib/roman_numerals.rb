class RomanNumerals

  def self.create(args)
    galactic_numerals = args[:galactic_numerals].split(' ')
    note = args[:note]
    num = []
    galactic_numerals.each do |string|
      num << note[string]
    end
    num.join('')
  end

end

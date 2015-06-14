class RomanNumerals

  def self.create(args)
    ig_query = args[:ig_query].split(' ')
    note = args[:note]
    num = []
    ig_query.each do |string|
      num << note[string]
    end
    num.join('')
  end

end

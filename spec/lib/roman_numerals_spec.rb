require 'spec_helper'
require 'roman_numerals'

describe RomanNumerals do

  describe '.create' do

    let(:note) { {"glob"=>"I", "prok"=>"V", "pish"=>"X", "tegj"=>"L"} }

    it 'returns a string' do
      resp = RomanNumerals.create(ig_query: 'glob prok', note: note)
      expect(resp).to be_a(String)
    end
    it 'return roman numerals from intergalactic numers' do
      resp = RomanNumerals.create(ig_query: 'pish tegj prok glob', note: note)
      expect(resp).to eq('XLVI')
    end
  end
end

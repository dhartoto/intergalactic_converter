require 'spec_helper'
require 'roman_numerals_validator'

describe RomanNumeralsValidator do

  describe '#validate' do

    Queryengine = Struct.new(:ig_query, :note, :num_query)
    let(:note) { {"glob"=>"I", "prok"=>"V", "pish"=>"X", "tegj"=>"L"} }
    let(:query) { Queryengine.new('glob prok', note)}

    before do
      allow(RomanNumerals).to receive(:create) {'XLVI'}
    end

    it 'returns Struct' do
      resp = RomanNumeralsValidator.new.validate(query)
      expect(resp).to be_a(Struct)
    end

    context 'when query is valid' do
      it 'valid? returns true' do
        resp = RomanNumeralsValidator.new.validate(query)
        expect(resp.valid?).to be_truthy
      end
      it 'message returns nil' do
        resp = RomanNumeralsValidator.new.validate(query)
        expect(resp.message).to be_nil
      end
    end

    context 'when query is invalid' do

      before do
        allow(RomanNumerals).to receive(:create) {'IIII'}
      end

      it 'valid? returns false' do
        resp = RomanNumeralsValidator.new.validate(query)
        expect(resp.valid?).to eq(false)
      end
      it 'returns input error message' do
        resp = RomanNumeralsValidator.new.validate(query)
        msg = "Input error: Check the order of your Intergalactic numerals"
        expect(resp.message).to eq(msg)
      end
    end
  end

  # Commented out because method is private
  # Test written to build private method with rules
  # describe '#valid?' do
  #   context 'returns true' do
  #     it 'when valid' do
  #       resp = RomanNumeralsValidator.new('IV').valid?
  #       expect(resp).to be_truthy
  #     end
  #   end
  #   context 'returns false' do
  #     it 'query contains four I in a row' do
  #       resp = RomanNumeralsValidator.new('IIII').valid?
  #       expect(resp).to eq(false)
  #     end
  #     it 'query contains four X in a row' do
  #       resp = RomanNumeralsValidator.new('XXXX').valid?
  #       expect(resp).to eq(false)
  #     end
  #     it 'query contains four M in a row' do
  #       resp = RomanNumeralsValidator.new('MMMM').valid?
  #       expect(resp).to eq(false)
  #     end
  #     it 'query contains invalid subtraction for X' do
  #       resp = RomanNumeralsValidator.new('VX').valid?
  #       expect(resp).to eq(false)
  #     end
  #     it 'query contains invalid subtraction for L' do
  #       resp = RomanNumeralsValidator.new('VL').valid?
  #       expect(resp).to eq(false)
  #     end
  #     it 'query contains invalid subtraction for C' do
  #       resp = RomanNumeralsValidator.new('LC').valid?
  #       expect(resp).to eq(false)
  #     end
  #     it 'query contains invalid subtraction for D' do
  #       resp = RomanNumeralsValidator.new('XD').valid?
  #       expect(resp).to eq(false)
  #     end
  #     it 'query contains invalid subtraction for M' do
  #       resp = RomanNumeralsValidator.new('XM').valid?
  #       expect(resp).to eq(false)
  #     end
  #     it 'query contains more than 1 small symbol before large' do
  #       resp = RomanNumeralsValidator.new('IIX').valid?
  #       expect(resp).to eq(false)
  #     end
  #   end
  # end

end

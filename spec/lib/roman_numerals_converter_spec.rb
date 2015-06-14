require 'spec_helper'
require 'roman_numerals_converter'

describe RomanNumeralsConverter do

  Query = Struct.new(:num_query)
  describe '#convert' do

    it 'converts I into 1' do
      query_obj = Query.new('I')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(1)
    end
    it 'converts II into 2' do
      query_obj = Query.new('II')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(2)
    end
    it 'converts V to 5' do
      query_obj = Query.new('V')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(5)
    end
    it 'converts X to 10' do
      query_obj = Query.new('X')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(10)
    end
    it 'converts L to 50' do
      query_obj = Query.new('L')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(50)
    end
    it 'converts C to 100' do
      query_obj = Query.new('C')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(100)
    end
    it 'converts D to 500' do
      query_obj = Query.new('D')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(500)
    end
    it 'converts M to 1000' do
      query_obj = Query.new('M')
      resp = RomanNumeralsConverter.new.convert(query_obj)

      expect(resp).to eq(1000)
    end
    it 'converts III to 3' do
      query_obj = Query.new('III')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(3)
    end
    it 'converts IV to 4' do
      query_obj = Query.new('IV')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(4)
    end
    it 'converts MCMIV to 1904' do
      query_obj = Query.new('MCMIV')
      resp = RomanNumeralsConverter.new.convert(query_obj)
      expect(resp).to eq(1904)
    end
  end
end

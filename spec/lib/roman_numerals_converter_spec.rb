require 'ostruct'
require 'spec_helper'
require 'roman_numerals_converter'

describe RomanNumeralsConverter do

  describe '#convert' do

    it 'converts I into 1' do
      test_query = OpenStruct.new(roman_numerals: 'I')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)
      expect(resp).to eq(1)
    end
    it 'converts V to 5' do
      test_query = OpenStruct.new(roman_numerals: 'V')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)
      expect(resp).to eq(5)
    end
    it 'converts X to 10' do
      test_query = OpenStruct.new(roman_numerals: 'X')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)
      expect(resp).to eq(10)
    end
    it 'converts L to 50' do
      test_query = OpenStruct.new(roman_numerals: 'L')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)
      expect(resp).to eq(50)
    end
    it 'converts C to 100' do
      test_query = OpenStruct.new(roman_numerals: 'C')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)
      expect(resp).to eq(100)
    end
    it 'converts D to 500' do
      test_query = OpenStruct.new(roman_numerals: 'D')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)
      expect(resp).to eq(500)
    end
    it 'converts M to 1000' do
      test_query = OpenStruct.new(roman_numerals: 'M')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)

      expect(resp).to eq(1000)
    end
    it 'converts III to 3' do
      test_query = OpenStruct.new(roman_numerals: 'III')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)
      expect(resp).to eq(3)
    end
    it 'converts IV to 4' do
      test_query = OpenStruct.new(roman_numerals: 'IV')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)
      expect(resp).to eq(4)
    end
    it 'converts MCMIV to 1904' do
      test_query = OpenStruct.new(roman_numerals: 'MCMIV')
      query_engine = OpenStruct.new(query: test_query)

      resp = RomanNumeralsConverter.new.convert(query_engine)
      expect(resp).to eq(1904)
    end
  end
end

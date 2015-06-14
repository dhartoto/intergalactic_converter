require 'ostruct'
require 'spec_helper'
require 'galactic_numerals_validator'

describe GalacticNumeralsValidator do

  describe '.new' do
    it 'sets valid to false' do
      validator = GalacticNumeralsValidator.new
      expect(validator).to be_valid
    end
  end

  describe '#validate' do

    let(:note) {{"glob"=>"I", "prok"=>"V", "pish"=>"X", "tegj"=>"L"}}

    context 'when query is valid' do

      let(:test_query) { OpenStruct.new(galactic_numerals: 'prok') }
      let(:query_engine) { OpenStruct.new(query: test_query, note: note) }

      it 'returns true' do
        resp = GalacticNumeralsValidator.new.validate(query_engine)
        expect(resp).to be_valid
      end
      it 'error_message returns nil' do
        resp = GalacticNumeralsValidator.new.validate(query_engine)
        expect(resp.error_message).to be_nil
      end
    end
    context 'when query is invalid' do

      let(:test_query) { OpenStruct.new(galactic_numerals: 'chicko') }
      let(:query_engine) { OpenStruct.new(query: test_query, note: note) }

      it 'valid? returns false' do
        resp = GalacticNumeralsValidator.new.validate(query_engine)
        expect(resp.valid?).to eq(false)
      end
      it 'return error message' do
        resp = GalacticNumeralsValidator.new.validate(query_engine)
        msg = "Input error: please check the spelling of your intergalactic numerals."
        expect(resp.error_message).to eq(msg)
      end
    end
  end
end

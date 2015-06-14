require 'spec_helper'
require 'galactic_numerals_validator'

describe GalacticNumeralsValidator do
  describe '#validate' do

    Queryengine = Struct.new(:ig_query, :note)
    let(:note) {{"glob"=>"I", "prok"=>"V", "pish"=>"X", "tegj"=>"L"}}
    let(:query) { Queryengine.new('prok', note)}

    it 'returns a Struct' do
      resp = GalacticNumeralsValidator.new.validate(query)
      expect(resp).to be_a(Struct)
    end
    context 'when query is valid' do
      it 'valid? returns true' do
        resp = GalacticNumeralsValidator.new.validate(query)
        expect(resp.valid?).to be_truthy
      end
      it 'message returns nil' do
        resp = GalacticNumeralsValidator.new.validate(query)
        expect(resp.message).to be_nil
      end
    end
    context 'when query is invalid' do
      let(:query) { Queryengine.new('chicko', note)}
      it 'valid? returns false' do
        resp = GalacticNumeralsValidator.new.validate(query)
        expect(resp.valid?).to eq(false)
      end
      it 'return error message' do
        resp = GalacticNumeralsValidator.new.validate(query)
        msg = "Input error: please check the spelling of your intergalactic numerals."
        expect(resp.message).to eq(msg)
      end
    end
  end
end

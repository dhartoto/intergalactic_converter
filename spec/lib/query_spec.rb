require 'spec_helper'
require 'query'

describe Query do

  describe '.new' do
    it 'sets valid? to false' do
      query = Query.new
      expect(query).not_to be_valid
    end

    it 'responds to type' do
      query = Query.new
      expect(query).to respond_to :type
    end

    it 'sets type to input value' do
      query = Query.new(type: '1')
      expect(query.type).to eq('1')
    end

    it 'responds to material' do
      query = Query.new
      expect(query).to respond_to :material
    end

    it 'responds to galactic_numerals' do
      query = Query.new
      expect(query).to respond_to :galactic_numerals
    end

    it 'responds to roman_numerals' do
      query = Query.new
      expect(query).to respond_to :roman_numerals
    end

  end

  describe '#build' do

    context 'when type == 1' do

      it 'sets galactic_numerals' do
        query = Query.new(type: '1')
        query.build("glob prok")
        expect(query.galactic_numerals).to eq("glob prok")
      end
      it 'does not set roman_numerals' do
        query = Query.new(type: '1')
        query.build("glob prok")
        expect(query.roman_numerals).to be_nil
      end
      it 'does not set material' do
        query = Query.new(type: '1')
        query.build("glob prok")
        expect(query.material).to be_nil
      end

    end

    context 'when type == 2' do

      it 'sets galactic_numerals' do
        query = Query.new(type: 2)
        query.build("glob prok Silver")
        expect(query.galactic_numerals).to eq("glob prok")
      end
      it 'sets material' do
        query = Query.new(type: 2)
        query.build("glob prok silver")
        expect(query.material).to eq("silver")
      end
      it 'does not set roman_numerals' do
        query = Query.new(type: 2)
        query.build("glob prok silver")
        expect(query.roman_numerals).to be_nil
      end

    end

  end

  describe '#valid?' do

    let(:query) { Query.new }

    it 'returns true if valid' do
      query.valid = true
      expect(query).to be_valid
    end
    it 'returns false if invalid' do
      expect(query).not_to be_valid
    end

  end

end

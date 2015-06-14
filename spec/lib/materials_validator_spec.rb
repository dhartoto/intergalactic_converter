require 'spec_helper'
require 'ostruct'
require 'materials_validator'

describe MaterialsValidator do

  describe '.new' do
    it 'sets valid to true' do
      query = MaterialsValidator.new
      expect(query).to be_valid
    end
  end

  describe '#validate' do

    let(:materials_value) { { 'silver'=>17, 'gold'=>14450, 'iron'=>195.5 } }
    let(:validator) { MaterialsValidator.new }

    context 'when query is valid' do

      let(:test_query) { OpenStruct.new(material: 'silver') }
      let(:query_engine) { OpenStruct.new(query: test_query, materials_value: materials_value, type: '2') }

      it 'returns true' do
        resp = validator.validate(query_engine)
        expect(resp).to be_valid
      end
      it 'error message returns nil' do
        resp = validator.validate(query_engine)
        expect(resp.error_message).to be_nil
      end

    end
    context 'when query is invalid' do

      let(:test_query) { OpenStruct.new(material: 'monkey') }
      let(:query_engine) { OpenStruct.new(query: test_query, materials_value: materials_value, type: '2') }

      it 'returns false' do
        resp = validator.validate(query_engine)
        expect(resp).not_to be_valid
      end
      it 'returns error message' do
        resp = validator.validate(query_engine)
        msg = "Sorry we do not have a value for monkey at this time."\
        "\nTry: silver, gold or iron"
        expect(resp.error_message).to eq(msg)
      end

    end

  end

end

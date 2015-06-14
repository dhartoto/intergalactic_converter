require 'spec_helper'
require 'query_engine'

describe QueryEngine do

  describe '.new' do

    before do
      allow(GalacticNumeralsValidator).to receive(:new)
      allow(RomanNumeralsValidator).to receive(:new)
    end

    context 'initialization success' do
      let(:resp) { double('resp') }
      let(:content) { {'glob'=>'I', 'prok'=>'V', 'pish'=>'X', 'tegj'=>'L', 'zyah'=>'C'} }

      before do
        allow(Note).to receive(:import) { resp }
        allow(resp).to receive_messages(loaded?: true, content: content)
      end

      it 'imports notes' do
        resp = QueryEngine.new('1')
        expect(resp.note).to eq(content)
      end
      it 'sets converter type' do
        resp = QueryEngine.new('1')
        expect(resp.type).to eq('1')
      end
      it 'sets query to be an instance of Query' do
        resp = QueryEngine.new('1')
        expect(resp.query).to be_an_instance_of(Query)
      end
      it 'sets converter to be an instance of RomanNumeralsConverter' do
        resp = QueryEngine.new('1')
        expect(resp.converter).to be_an_instance_of(RomanNumeralsConverter)
      end
      it 'sets output to nil' do
        resp = QueryEngine.new('1')
        expect(resp.output).to eq(nil)
      end

    end

    context 'when note fails to load' do
      let(:resp) { double('resp') }
      let(:msg) { "File not found! Please check that you've loaded note.txt to"\
        " the public folder and start up the program again." }

      before do
        allow(Note).to receive(:import) { resp }
        allow(resp).to receive_messages(loaded?: false, error_message: msg, gets: msg)
      end

      it 'raise error' do
        resp = lambda{ QueryEngine.new('1') }
        expect(resp).to raise_error(SystemExit, msg)
      end
    end
  end

  describe '#run' do

    context 'when converter type 1' do

      let(:app) { QueryEngine.new('1') }

      it 'returns conversion of intergalactic numerals ' do
        allow_any_instance_of(Query).to receive(:roman_numerals) { 'IV' }
        allow(app).to receive(:gets) {'glob prok'}
        app.run
        expect(app.output).to eq('glob prok is 4')
      end
    end

    context 'when converter type 2' do
      let(:app) { QueryEngine.new('2') }

      context 'when user enters intergalactic numeral with material type' do
        it 'returns total value of material' do
          allow(app).to receive(:gets) {'glob prok Platinum'}
          app.run
          expect(app.output).to eq('glob prok Platinum is 80 Credits.')
        end
      end
      context 'when user only enters a material type' do
        it 'returns the value of the material' do
          allow(app).to receive(:gets) {'Platinum'}
          app.run
          expect(app.output).to eq('Platinum is 20 Credits.')
        end
      end
    end
  end

end

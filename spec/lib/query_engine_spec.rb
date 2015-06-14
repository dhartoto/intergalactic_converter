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
      let(:content) { {'glob'=>'I', 'prok'=>'V', 'pish'=>'X', 'tegj'=>'L'} }

      before do
        allow(Note).to receive(:import) { resp }
        allow(resp).to receive_messages(loaded?: true, content: content)
      end

      it 'loads commodities in a Struct' do
        resp = QueryEngine.new('1')
        expect(resp.materials).to be_a(Hash)
      end
      it 'imports notes' do
        resp = QueryEngine.new('1')
        expect(resp.note).to be_a(Hash)
      end
      it 'sets num_query to blank string' do
        resp = QueryEngine.new('1')
        expect(resp.num_query).to eq("")
      end
      it 'sets mat_query to blank string' do
        resp = QueryEngine.new('1')
        expect(resp.mat_query).to eq("")
      end
      it 'sets converter type' do
        resp = QueryEngine.new('1')
        expect(resp.type).to eq('1')
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
    let(:resp) { double('resp') }
    let(:gnv_resp) { double('gnv_resp') }


    before do
      allow(GalacticNumeralsValidator).to receive(:new){ resp }
      allow(RomanNumeralsValidator).to receive(:new){ resp }
      allow(Note).to receive(:import){ resp }
      allow(resp).to receive_messages(
        loaded?: true,
        content: {"glob"=>"I", "prok"=>"V", "pish"=>"X", "tegj"=>"L"},
        validate: gnv_resp
      )
      allow(gnv_resp).to receive_messages(valid?: true, message:'')
    end

    context 'when converter type 1' do
      let(:app) { QueryEngine.new('1') }

      it 'sets ig_query' do
        allow(app).to receive(:gets) {'glob prok'}
        app.run
        expect(app.ig_query).to eq('glob prok')
      end
    end

    context 'when converter type 2' do
      let(:app) { QueryEngine.new('2') }
      let(:converter) { double('converter') }

      before do
        allow(RomanNumeralsConverter).to receive(:new){ converter }
        allow(converter).to receive(:convert){ 1 }
      end

      it 'sets ig_query' do
        allow(app).to receive(:gets) {'glob prok Silver'}
        app.run
        expect(app.ig_query).to eq('glob prok')
      end
      it 'sets mat_query' do
        allow(app).to receive(:gets) {'glob prok Silver'}
        app.run
        expect(app.mat_query).to eq('silver')
      end
      it 'sets mat_query to platinum' do
        allow(app).to receive(:gets) {'glob prok Platinum'}
        app.run
        expect(app.mat_query).to eq('platinum')
      end
    end

  end

end

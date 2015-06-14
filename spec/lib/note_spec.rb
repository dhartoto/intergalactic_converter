require 'spec_helper'
require 'note'

describe Note do

  describe '.import' do

    context 'file not absent' do

      before do
        allow(File).to receive(:exists?){ false }
      end

      it 'should return a Struct' do
        resp = Note.import
        expect(resp).to be_a(Struct)
      end
      it 'responds false to loaded?' do
        resp = Note.import
        expect(resp.loaded?).to eq(false)
      end
      it 'responds nil to content' do
        resp = Note.import
        expect(resp.content).to be_nil
      end
      it 'responds error message to error_message' do
        resp = Note.import
        msg = "I can't seem to find note.txt. Please check that you've added it"\
              " to the public folder then start me up again!"
        expect(resp.error_message).to eq(msg)
      end
    end

    context 'file is empty' do
      let(:data) { "" }

      before do
        allow(File).to receive_messages(exists?: true, read: data)
      end

      it 'should return a Struct' do
        resp = Note.import
        expect(resp).to be_a(Struct)
      end
      it 'loaded? should return false' do
        resp = Note.import
        expect(resp.loaded?).to eq(false)
      end
      it 'responds nil to content' do
        resp = Note.import
        expect(resp.content).to be_nil
      end
      it 'should return error message'do
        resp = Note.import
        msg = "The notes appear to be empty. Please add some notes then start me"\
              " up again!"
        expect(resp.error_message).to eq(msg)
      end
    end

    context 'txt file and content present' do

      let(:data) { "glob is I\rprok is V\rpish is X\rtegj is L\rzyah is C" }

      before do
        allow(File).to receive_messages(exists?: true, read: data)
      end

      it 'should return a Struct' do
        resp = Note.import
        expect(resp).to be_a(Struct)
      end
      it 'loaded? should return true' do
        resp = Note.import
        expect(resp.loaded?).to eq(true)
      end
      it 'responds nil to error_message' do
        resp = Note.import
        expect(resp.error_message).to be_nil
      end
      it 'content should return Hash' do
        resp = Note.import
        expect(resp.content).to be_a(Hash)
      end

      it 'should set Intergalactic numerals as hash key' do
        resp = Note.import
        keys = ['glob', 'prok', 'pish', 'tegj', 'zyah']
        expect(resp.content.keys).to eq(keys)
      end

      it 'should set Intergalactic numerals with 5 keys' do
        resp = Note.import
        expect(resp.content.keys.length).to eq(5)
      end

      it 'should set Roman numerals as hash value' do
        resp = Note.import
        values = ['I', 'V', 'X', 'L', 'C']
        expect(resp.content.values).to eq(values)
      end
    end

  end

end

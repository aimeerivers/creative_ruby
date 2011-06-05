require 'spec_helper'

describe Note do

  let(:note) { Note.new(50, 1, 100) }
  let(:midi) { mock(:midi) }

  before do
    LiveMIDI.stub(:instance).and_return(midi)
  end

  describe 'playing a note' do
    it 'plays a note on the midi' do
      midi.should_receive(:note_on).with(1, 50, 100)
      note.play
    end
  end

  describe 'stopping a note' do
    it 'sends a note_off message to the midi' do
      midi.should_receive(:note_off).with(1, 50)
      note.stop
    end
  end

end

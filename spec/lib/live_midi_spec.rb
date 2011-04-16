require 'spec_helper'

describe LiveMidiWrapper do

  let(:midi)    { mock :midi }
  let(:wrapper) { LiveMidiWrapper.new(midi) }

  describe 'choosing an instrument' do
    it 'sets the instrument for a channel' do
      midi.should_receive(:program_change).with(1, 1)
      wrapper.choose_instrument :piano, for_channel: 1
    end

    it 'sets a different instrument for a different channel' do
      midi.should_receive(:program_change).with(2, 10)
      wrapper.choose_instrument :music_box, for_channel: 2
    end

    it 'chooses channel 1 if not otherwise specified' do
      midi.should_receive(:program_change).with(1, 10)
      wrapper.choose_instrument :music_box
    end

    it 'raises an error if the instrument is unknown' do
      lambda { wrapper.choose_instrument :non_instrument }.should raise_error(InstrumentNotKnownError)
    end
  end

  describe 'playing a note' do
    it 'starts playing the note' do
      midi.should_receive(:note_on).with(2, 50)
      wrapper.play_note 50, on_channel: 2
    end

    it 'chooses channel 1 unless otherwise specified' do
      midi.should_receive(:note_on).with(1, 50)
      wrapper.play_note 50
    end
  end

end

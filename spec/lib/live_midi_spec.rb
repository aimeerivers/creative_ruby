require 'spec_helper'

describe LiveMidiWrapper do

  let(:midi)    { mock :midi }
  let(:wrapper) { LiveMidiWrapper.new(midi) }

  describe 'choosing a sound' do
    it 'sets the sound for a channel' do
      midi.should_receive(:program_change).with(1, 1)
      wrapper.choose_sound :piano, for_channel: 1
    end

    it 'sets a different sound for a different channel' do
      midi.should_receive(:program_change).with(2, 10)
      wrapper.choose_sound :music_box, for_channel: 2
    end

    it 'chooses channel 1 if not otherwise specified' do
      midi.should_receive(:program_change).with(1, 10)
      wrapper.choose_sound :music_box
    end
  end

end

require 'spec_helper'

describe LiveMidiWrapper do

  let(:midi)    { LiveMIDI.new }
  let(:wrapper) { LiveMidiWrapper.new(midi) }

  describe 'choosing a sound' do
    it 'sets the sound for a channel' do
      midi.should_receive(:program_change).with(1, 1)
      wrapper.choose_sound :piano, for_channel: 1
    end
  end

end

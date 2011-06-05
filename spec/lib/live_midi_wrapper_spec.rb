require 'spec_helper'

describe LiveMidiWrapper do

  let(:midi)    { mock :midi }
  let(:wrapper) { LiveMidiWrapper.new }

  before do
    LiveMIDI.stub(:instance).and_return(midi)
  end

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

    it 'can take an instrument number instead of a named instrument' do
      midi.should_receive(:program_change).with(1, 10)
      wrapper.choose_instrument 10
    end
  end

  describe 'playing a note' do
    let(:note) { mock(:note, play: true) }

    before do
      Note.stub(:new).and_return(note)
    end

    it 'creates a note' do
      Note.should_receive(:new).with(50, 2, nil)
      wrapper.play_note 50, on_channel: 2
    end

    it 'plays the note it has just created' do
      note.should_receive(:play)
      wrapper.play_note 50, on_channel: 2
    end

    it 'chooses channel 1 unless otherwise specified' do
      Note.should_receive(:new).with(50, 1, nil)
      wrapper.play_note 50
    end

    it 'can optionally have a velocity' do
      Note.should_receive(:new).with(80, 1, 100)
      wrapper.play_note 80, with_velocity: 100
    end
  end

  describe 'stopping all notes that are playing' do
    let(:note) { mock(:note) }

    it 'remembers notes it has played to turn them off again' do
      Note.stub(:new).and_return(note)
      note.stub(:play)
      wrapper.play_note 50, on_channel: 3

      note.should_receive(:stop)
      wrapper.stop_all
    end
  end

end

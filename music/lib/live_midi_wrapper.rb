class InstrumentNotKnownError < StandardError; end

class LiveMidiWrapper

  INSTRUMENTS = {
    piano: 1,
    music_box: 10
  }

  def initialize(midi)
    @midi = midi
  end

  def choose_instrument(instrument, options = {})
    instrument = INSTRUMENTS[instrument]
    raise InstrumentNotKnownError if instrument.nil?
    @midi.program_change(options[:for_channel] || 1, instrument)
  end

  def play_note(pitch, options = {})
    @midi.note_on(options[:on_channel] || 1, pitch)
  end

end

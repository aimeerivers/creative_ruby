class InstrumentNotKnownError < StandardError; end

class LiveMidiWrapper

  INSTRUMENTS = {
    piano: 1,
    piano_2: 2,
    honky_tonk: 3,
    electric_piano: 4,
    electric_piano_2: 5,
    harpsichord: 6,
    clavinet: 7,
    celesta: 8,
    glockenspiel: 9,
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
    channel = options[:on_channel] || 1
    velocity = options[:with_velocity]
    @midi.note_on(channel, pitch, velocity)
  end

end

require 'note'

class InstrumentNotKnownError < StandardError; end

class LiveMidiWrapper

  DEFAULT_CHANNEL = 1

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

  def initialize
    @played_notes = []
    @midi = LiveMIDI.instance
  end

  def choose_instrument(instrument, options = {})
    instrument = INSTRUMENTS[instrument] if instrument.is_a? Symbol
    raise InstrumentNotKnownError if instrument.nil?
    @midi.program_change(options[:for_channel] || DEFAULT_CHANNEL, instrument)
  end

  def play_note(pitch, options = {})
    channel = configure_channel(options)
    velocity = options[:with_velocity]
    note = Note.new(pitch, channel, velocity)
    @played_notes << note
    note.play
  end

  def stop_all
    @played_notes.each do |note|
      note.stop
    end
  end

  private

  def configure_channel(options)
    options[:on_channel] || DEFAULT_CHANNEL
  end

end

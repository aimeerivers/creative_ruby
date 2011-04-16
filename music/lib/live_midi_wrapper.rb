class InstrumentNotKnownError < StandardError; end

class LiveMidiWrapper

  SOUNDS = {
    piano: 1,
    music_box: 10
  }

  def initialize(midi)
    @midi = midi
  end

  def choose_sound(sound, options = {})
    sound = SOUNDS[sound]
    raise InstrumentNotKnownError if sound.nil?
    @midi.program_change(options[:for_channel] || 1, sound)
  end

end

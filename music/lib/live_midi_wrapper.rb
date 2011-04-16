class LiveMidiWrapper

  SOUNDS = {
    piano: 1
  }

  def initialize(midi)
    @midi = midi
  end

  def choose_sound(sound, options)
    @midi.program_change(options[:for_channel], SOUNDS[sound])
  end

end

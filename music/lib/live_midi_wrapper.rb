class LiveMidiWrapper

  SOUNDS = {
    piano: 1,
    music_box: 10
  }

  def initialize(midi)
    @midi = midi
  end

  def choose_sound(sound, options = {})
    @midi.program_change(options[:for_channel] || 1, SOUNDS[sound])
  end

end

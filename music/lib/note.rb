class Note

  attr_reader :pitch, :channel, :velocity

  def initialize(pitch, channel, velocity)
    @pitch = pitch
    @channel = channel
    @velocity = velocity
    @midi = LiveMIDI.instance
  end

  def play
    @midi.note_on(@channel, @pitch, @velocity)
  end

  def stop
    @midi.note_off(@channel, @pitch)
  end

end

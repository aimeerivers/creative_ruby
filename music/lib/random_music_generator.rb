require 'live_midi'
require 'live_midi_wrapper'

class RandomMusicGenerator

  def initialize
    @midi = LiveMidiWrapper.new(LiveMIDI.new)
  end

  def play_music
    @midi.choose_instrument :music_box, for_channel: 1
    while true do
      note = rand(90) + 10
      time = rand(3)
      puts "Playing note #{note} for #{time} seconds"
      @midi.play_note note, on_channel: 1, with_velocity: 100
      sleep(time)
    end
  end

end

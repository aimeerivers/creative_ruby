require 'live_midi'
require 'live_midi_wrapper'

class RandomMusicGenerator

  def initialize
    @midi = LiveMidiWrapper.new
  end

  def play_music
    @midi.choose_instrument 18, for_channel: 0
    @midi.play_note 50, on_channel: 0, with_velocity: 60

    @midi.choose_instrument :music_box, for_channel: 1
    5.times do
      note = rand(90) + 10
      time = rand(3)
      puts "Playing note #{note} for #{time} seconds"
      @midi.play_note note, on_channel: 1, with_velocity: 100
      sleep(time)
    end

    @midi.stop_all
  end

end

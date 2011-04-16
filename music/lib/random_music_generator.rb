require 'live_midi'

class RandomMusicGenerator < LiveMIDI

  def play_music
    self.program_change(1, 1)
    while true do
      note = rand(90) + 10
      time = rand(3)
      puts "Playing note #{note} for #{time} seconds"
      self.note_on(1, note, 100)
      sleep(time)
    end
  end

end

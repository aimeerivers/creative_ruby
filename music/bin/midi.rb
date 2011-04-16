$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'random_music'

music_generator = RandomMusic.new
music_generator.play_music

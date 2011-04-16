$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'random_music_generator'

music_generator = RandomMusicGenerator.new
music_generator.play_music

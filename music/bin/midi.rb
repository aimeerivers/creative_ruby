$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'live_midi'

midi = LiveMIDI.new
midi.run

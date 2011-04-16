$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'run_midi'

midi = RunMidi.new
midi.run

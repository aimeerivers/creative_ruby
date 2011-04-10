every 4.beats do
  instrument(1).play 'Cmajor' # play Cmajor with instrument 1
end

every 4.beats do
  bass = 'C'.down 2           # a bass tone
  bass.duration = 4.beats     # four beats long
  instrument(1) << bass       # sent to instrument 1
  instrument(1).play          # and played
end

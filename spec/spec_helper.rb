$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'music', 'lib'))
Dir["#{File.dirname(__FILE__)}/../music/lib/**/*.rb"].each {|f| require f}

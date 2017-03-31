Dir[File.expand_path('../endpoint/*.rb', __FILE__)].each{|f| require f}
Dir[File.expand_path('../endpoint/**/*.rb', __FILE__)].each{|f| require f}

# this is myserver_control.rb

require 'rubygems'        # if you use RubyGems
require 'daemons'

puts "Iniciando..."
$directorio = Dir.pwd
Daemons.run('lugbot_server.rb')

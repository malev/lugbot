Dir.chdir($directorio)

require 'rubygems'
require 'parseconfig'
require 'logger'
require 'lib/isaac.rb'
require 'lib/datos.rb'
require 'lib/controllers.rb'

$LOG = Logger.new('log/log_file.log', 'monthly') 
myconfig = ParseConfig.new('config/irc.conf')

configure do |c|
  c.nick    = myconfig.get_value('nick')
  c.server  = myconfig.get_value('server')
  c.port    = myconfig.get_value('port').to_i
  c.verbose = false
  c.environment = :test
  
end

on :connect do
  join "#lugtucuman"
end

on :channel, // do
  Mensajes.create(:nick => nick, :msg => message)
end

on :private, /^exportar/ do
#  modo = match[0]
#  if (auth && auth.expirado?)
#    export_file
#    msg nick, "You export file has been generated."
#  else
#    auth = nil
#    msg nick, "You must loggin first!"
#  end
  Mensajes.export_file
end

#on :private, /^login (\S+) (\S+)/ do
#  username = match[0]
#  password = match[1]
#  auth = Sessions.new(username, password, nick)
#  msg nick, "Login successful!" if @auth
#end



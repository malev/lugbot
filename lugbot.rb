require 'lib/isaac.rb'
require 'rubygems'
require 'parseconfig'
require 'mvc/datos.rb'
require 'mvc/controllers.rb'
require 'logger'

$LOG = Logger.new('log/log_file.log', 'monthly') 
myconfig = ParseConfig.new('config/irc.conf')

configure do |c|
  c.nick    = myconfig.get_value('nick')
  c.server  = myconfig.get_value('server')
  c.port    = myconfig.get_value('port').to_i
  c.verbose = true
end

on :connect do
  join "#lugtucuman"
end

on :private, /^exportar (\S+)/ do
  modo = match[0]
  if (auth && auth.expirado?)
    export_file
    msg nick, "You export file has been generated."
  else
    auth = nil
    msg nick, "You must loggin first!"
  end
end

on :private, /^login (\S+) (\S+)/ do
  username = match[0]
  password = match[1]
  auth = Sessions.new(username, password, nick)
  msg nick, "Login successful!" if @auth
end

on :channel, // do
  createm(:nick => nick, :msg => message)
end

#on :private /^record/ do
#  
#end

##<< :elbotboton!n=blah@host48.190-31-103.telecom.net.ar JOIN :#lugtucuman
##<< :elbotboton!n=blah@host48.190-31-103.telecom.net.ar QUIT :Remote closed the connection

#helpers do
#  def check
#    msg channel, "this channel, #{channel}, is awesome!"
#  end
#end

#on :connect do
#  join "#lugtucuman"
#  msg 'asdfhaskfdhaskdfhaskdfasdf', 'foo'
#end

#on :private, /^t (.*)/ do
#  msg nick, "You said: " + match[1]
#end

#on :channel, /quote/ do
#  msg channel, "#{nick} requested a quote: 'Smoking, a subtle form of suicide.' - Vonnegut"
#end

#on :channel, /status/ do
#  check
#end

#on :error, 401 do
#  puts "Ok, #{nick} doesn't exist."
#end

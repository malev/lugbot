require 'lib/isaac.rb'
require 'rubygems'
require 'parseconfig'
require 'mvc/datos.rb'

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

on :channel, /grabar/ do
  msg channel, "ahora comenzamos a grabar"
end

on :channel, /offrecord/ do
  msg channel, "ahora dejamos de grabar"
end

on :private, /^login (\S+) (\S+)/ do
  username = match[0]
  password = match[1]
  # do something to authorize or whatevz.
  msg nick, "Login successful!" if (username == "malev" && password == "genius")
  
  msg nick, "Esperando..."
end

#<< :elbotboton!n=blah@host48.190-31-103.telecom.net.ar JOIN :#lugtucuman
#<< :elbotboton!n=blah@host48.190-31-103.telecom.net.ar QUIT :Remote closed the connection

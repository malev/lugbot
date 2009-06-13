require 'lib/isaac.rb'
require 'rubygems'
require 'parseconfig'
require 'mvc/datos.rb'
require 'mvc/controllers.rb'

verif = []

myconfig = ParseConfig.new('config/irc.conf')

configure do |c|
  c.nick    = myconfig.get_value('nick')
  c.server  = myconfig.get_value('server')
  c.port    = myconfig.get_value('port').to_i
  c.verbose = true
end

on :connect do
  join "#ruby-lang"
end

on :private, /^login (\S+) (\S+)/ do
  username = match[0]
  password = match[1]
  # do something to authorize or whatevz.
  msg nick, "Login successful!" if (username == "malev" && password == "genius")
  msg nick, "Esperando..."

end

on :channel, // do
  createm :msg => msg, :nick => nick
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

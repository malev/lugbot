require 'rubygems'
require 'lib/isaac'

#configure do |c|
#  c.username = "bostonrbot"
#  c.realname = "bostonrb logger bot"
#  c.nick    = "b55rbot"
#  c.server  = "irc.freenode.net"
#  c.port    = 6667
#  c.vervose = true
#end
configure do |c|
  c.nick    = 'hola67'
  c.server  = "irc.freenode.net"
  c.port    = 6667
  c.verbose = true
end
on :connect do
  join "#boston.rb"
end

on :channel, /.*/ do
  open("#{channel}.log", "a") do |log|
    log.puts "#{nick}: #{message}"
  end

  puts "#{channel}: #{nick}: #{message}"
end


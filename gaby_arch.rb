require '../lib/isaac.rb'

configure do |c|
  c.nick    = "gaby_arch"
  c.server  = "irc.freenode.net"
  c.port    = 6667
  c.verbose = true
end

on :connect do
  join "#lugtucuman"
end

on :channel, /^quote this: (.*)/ do
  msg channel, "Quote: '#{match[0]}' by #{nick}"
end

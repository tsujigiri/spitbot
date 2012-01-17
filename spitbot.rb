#!/usr/bin/env ruby
# see http://rubydoc.info/github/cinchrb/cinch/master/file/README.md
# for Cinch documentation

require 'yaml'
require 'bundler'
Bundler.require

Dir.foreach("plugins") do |file|
  if file[/\.rb\Z/]
    puts "loading plugins/#{file}"
    require "./plugins/#{file}" 
  end
end

config = YAML.load(File.read("config.yml"))
puts config.inspect

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = "spitbot"
    c.server = config["server"]
    c.password = config["password"]
    c.channels = config["channels"]
    c.plugins.plugins = [UrbanDictionary]
  end

  on :message, /spitbot/i do |m|
    m.reply "I see what you are doing, #{m.user.nick}."
  end
end

bot.start

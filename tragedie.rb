require 'rubygems'
require 'bundler/setup'
require 'mastodon'
require 'json'
require 'date'

# the whole script is run by a scheduler on heroku

# parse config file
config = JSON.parse(File.read('config.json'))

# token must be set as env variable
bearer_token = ENV['MASTODON_BEARER_TOKEN']

# mastodon REST client
client = Mastodon::REST::Client.new(base_url: config['instance_url'], bearer_token: bearer_token)

# lyrics ♫
lyrics = File.readlines(config['lyrics_file'])

# get random lyrics to toot
random_lyrics = "♫ " + lyrics.sample.chomp + " ♫"
# log
puts "#{DateTime.now.strftime("%d/%m/%Y %H:%M")}: 📯 #{random_lyrics}"
# toot a random sample from the lyrics
client.create_status(random_lyrics)
# log end of task, terminate
puts "#{DateTime.now.strftime("%d/%m/%Y %H:%M")}: 👍 😴"

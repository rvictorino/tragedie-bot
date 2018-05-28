require 'rubygems'
require 'bundler/setup'
require 'mastodon'
require 'json'
require 'date'


# constant
FRENQUENCY = 8 * 3600 # 8 hours

# parse config file
config = JSON.parse(File.read('config.json'))

# token must be set as env variable
bearer_token = ENV['MASTODON_BEARER_TOKEN']

# mastodon REST client
client = Mastodon::REST::Client.new(base_url: config['instance_url'], bearer_token: bearer_token)

# lyrics ♫
lyrics = File.readlines(config['lyrics_file'])

# endless loop ☠
while true
  random_lyrics = "♫ " + lyrics.sample.chomp + " ♫"
  puts "#{DateTime.now.strftime("%d/%m/%Y %H:%M")}: 📯 #{random_lyrics}"
  # toot a random sample from the lyrics
  client.create_status(random_lyrics)
	puts "#{DateTime.now.strftime("%d/%m/%Y %H:%M")}: 😴"
  sleep(FRENQUENCY)
end

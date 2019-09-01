#!/usr/bin/env ruby
require "rubygems"
require "rest_client"
require "twitter"
require "open-uri"
require "json"
path = '/path/to/this/file/and/card/list/'
totalurl = ''
filename = "cardid.txt"  
postedfilename="posted.txt"
logname="log.txt"
apiurl = 'https://api.scryfall.com/cards/multiverse/'
fullpath = "#{path}#{filename}"
postedfullpath = "#{path}#{postedfilename}"
logfullpath = "#{path}#{logname}"

time = Time.new
date = time.strftime("%d/%m/%Y")
time = time.strftime("%k:%M")           # "17:48"

open("#{logfullpath}", "a") do |g|

g.puts "### Loop begins at #{time} on #{date} ###"

place = 0

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "CONSUMER KEY GOES HERE"
  config.consumer_secret     = "CONSUMER SECRET KEY GOES HERE"
  config.access_token        = "ACCESS TOKEN GOES HERE"
  config.access_token_secret = "SECRET ACCESS TOKEN GOES HERE"
end

count = IO.readlines(fullpath).size

puts("#{time},#{date}: Checked #{fullpath} size. #{count} cards.")
g.puts("#{time},#{date}: Checked #{fullpath} size. #{count} cards.")

randomcard = rand(count)
cardurl = IO.readlines(fullpath)[randomcard]
puts("#{time},#{date}: Selected card #{randomcard}")
g.puts("#{time},#{date}: Selected card #{randomcard}")

countcheck = IO.readlines(postedfullpath).size
puts("#{time},#{date}: Checked #{postedfullpath} card database size. #{countcheck}")
puts("#{time},#{date}: Iterating to prevent duplicate posts.")
g.puts("#{time},#{date}: Checked #{postedfullpath} card database size. #{countcheck}")
g.puts("#{time},#{date}: Iterating to prevent duplicate posts.")

loop do
	#puts "Checking #{postedfullpath} at index: #{place}"
	#g.puts "Checking #{postedfullpath} at index: #{place}"
	checkurl = IO.readlines(postedfullpath)[place]
	cardurl.to_s
	checkurl.to_s
	#puts "Want to post: cardurl #{cardurl}"
	#puts "Checking against: checkurl #{checkurl}"
	#g.puts "Want to post: cardurl #{cardurl}"
	#g.puts "Checking against: checkurl #{checkurl}"
	
	if checkurl == cardurl
		parseuts "#{time},#{date}: Match found. Seed new random card."
		g.puts "#{time},#{date}: Match found. Seed new random card."
		place = 0
		randomcard = rand(count)
		cardurl = IO.readlines(fullpath)[randomcard]
		puts "#{time},#{date}: New random card: #{cardurl}"
		g.puts "#{time},#{date}: New random card: #{cardurl}"
	else
			place+=1
	end
	
	
	if place == countcheck
		break	
	end
end

cardurl = cardurl.strip
totalurl = "#{apiurl}#{cardurl}"
encoded_url = URI.encode(totalurl)
puts("#{time},#{date}: Built API URL: #{encoded_url}")
g.puts("#{time},#{date}: Built API URL: #{encoded_url}")

uri = URI("#{encoded_url}")
response = Net::HTTP.get(uri)
json = JSON.parse(response)

#p json

puts("#{time},#{date}: Checking card layout type.")
g.puts("#{time},#{date}: Checking card layout type.")

cardlayout = json['layout']
if cardlayout == "transform"
	puts("#{time},#{date}: Layout is transform")
	g.puts("#{time},#{date}: Layout is transform")
	frontbackrandom = rand(2)
	puts "#{frontbackrandom}"
	imageurl = json['card_faces'][frontbackrandom]['image_uris']['large']
	name = json['name']
	set = json['set_name']
else
	puts("#{time},#{date}: Layout is standard")
	g.puts("#{time},#{date}: Layout is standard")

	imageurl = json['image_uris']['large']
	name = json['name']
	set = json['set_name']
end

puts "#{time},#{date}: #{name}"
puts "#{time},#{date}: #{imageurl}"
puts "#{time},#{date}: #{set}"
g.puts "#{time},#{date}: #{name}"
g.puts "#{time},#{date}: #{imageurl}"
g.puts "#{time},#{date}: #{set}"

download = open(imageurl)
IO.copy_stream(download, "#{path}newCard.jpeg")

puts("#{time},#{date}: Downloaded card art: #{path}newCard.jpeg")
g.puts("#{time},#{date}: Downloaded card art: #{path}newCard.jpeg")

client.update_with_media("#{name}, #{set}, #mtg", File.new("#{path}newCard.jpeg"))
puts("#{time},#{date}: Posted to Twitter! #{name}, #{set}, #mtg, #{path}newCard.jpeg")
g.puts("#{time},#{date}: Posted to Twitter! #{name}, #{set}, #mtg, #{path}newCard.jpeg")

open("#{postedfullpath}", "a") do |f|
	f.puts "#{cardurl}"
	puts("#{time},#{date}: Appending #{cardurl} to posted file")
	g.puts("#{time},#{date}: Appending #{cardurl} to posted file")

end
g.puts "### Loop ends at #{time} on #{date} ###"

end


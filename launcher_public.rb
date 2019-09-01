require "rubygems"
require "rufus-scheduler"

scheduler = Rufus::Scheduler.new	

scheduler.every("2m")do
	require "/home/pi/Bots/mtgbotpublic.rb"
end

scheduler.join

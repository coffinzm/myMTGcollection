# myMTGcollection

## Intro/Disclaimer/Etc ##
Disclaimer: I am a hobbyist coder -- my code could probably be improved upon/be prettier. Please tweak it to your heart's content.

This Twitter bot is coded in Ruby and should run across platforms. My install lives on a Raspberry Pi Zero running Raspbian.

My bot's posts can be found here: https://twitter.com/mymtgcollection

Have your bot follow mine--I'll have mine follow yours back!

## Collection Management and Card IDs: ##

My colletion is managed with the amazing **Magic Assistant**. http://mtgbrowser.sourceforge.net/wiki/index.php/Main_Page

This program can export a text file containing each card's unique **Multiverse ID**.

It is not necessary to use MTG Assistant to make the bot function. However, a list of Multiverse IDs (a card collection) is a necessity. 

Multiverse IDs are assigned by WoTC and can be found at the end of each card's Gatherer URL. For example: https://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=9764


## Project Files ##
You'll find populated versions of the following files to demonstrate how they work. You'll want to delete/replace their contents before using this code for your own collection.

*Text Files*
+ *cardid.txt*: contains a list of Multiverse IDs. The bot reads this file to select a random card. This represents a card collection.
+ *posted.txt*: contains a list of cards which have already been posted. This prevents duplicate posts.
+ *log.txt*: a log detailing each post. Was used in development for debugging.

*Ruby Scripts*
+ *mymtgbotpublic.rb*: The backbone of the operation. Handles random card selection/posting to Twitter.
+ *launcher_public.rb*: A script that runs *mymtgcollectionpublic.rb* once every twelve hours.

## Required Software ##
This project is made possible by some very helpful pieces of software:
+ Ruby Gem: *rest-client* https://rubygems.org/gems/rest-client/versions/1.8.0
+ Ruby Gem: *twitter* https://rubygems.org/gems/twitter/versions/6.2.0
+ Ruby Gem: *json* https://rubygems.org/gems/json/versions/1.8.3
+ Ruby Gem: *rufus-scheduler* https://rubygems.org/gems/rufus-scheduler/versions/3.2.0

## Setup/Install ##
+ Create a Twitter Developer Account and locate your Access Tokens
https://developer.twitter.com/en/docs/basics/authentication/guides/access-tokens.html
+ Add these tokens to *mymtgbotpublic.rb* where specified. There are four fields to update on lines 28 - 31.
+ Update *path* on line seven of *mymtgbotpublic.rb* to reflect its location. This directory should also contain: *cardid.txt*, *posted.txt*, *log.txt*, and *launcher_public.rb*.
+ Update *path* on line seven of *launcher_public.rb* to reflect its location.
+ Secure a list of Multiverse IDs and add them to *cardid.txt*. This file represents your collection.
+ Delete the contents of *log.txt* and *posted.txt*
+ Test this configuration by navigating to the directory containing the program. Issue the command "ruby mymtgbotpublic.rb". You should see console/log output and, if correctly setup, a Tweet will post
+ Execute the command "ruby launcher_public.rb" and allow the program to run. Don't fret! You won't see any output unless a card is being posted. This script creates a thread which will run in the backgroud; you may exit the console used to execute this script. You're all set!

## Notes ##
+ The wonderful Scryfall API makes this all possible. Support their work! https://www.patreon.com/scryfall/posts
+ My instance of this program lives on its own Raspberry Pi Zero, running Raspbian https://www.raspberrypi.org/downloads/raspbian/
+ Magic Assistant is a phenomenal open source piece of software. I highly recommend it to anyone who wants to better manage his or her card collection. http://mtgbrowser.sourceforge.net/wiki/index.php/Main_Page
+ You can update your collection by appending *cardid.txt*. If you update this file without touching *posted.txt*, you will never post a duplicate card.
+ The version of *cardid.txt* shared here reflects the current state of my collection!

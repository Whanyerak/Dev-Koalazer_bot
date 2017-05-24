#Run Command Line: 
# => "$ruby koalazer_bot.rb" -> to run it with a direct view on the state of the bot.

#You can also run it with Command Line: 
# => "$ruby koalazer_bot.rb > logs.txt 2>&1" -> to save the state of the process in a log file.

require 'discordrb'
require_relative 'player_control'
require_relative 'music'

Discordrb::Channel
# This statement creates a bot with the specified token and application ID. After this line, you can add events to the
# created bot, and eventually run it.
#
# If you don't yet have a token and application ID to put in here, you will need to create a bot account here:
#   https://discordapp.com/developers/applications/me
# If you're wondering about what redirect URIs and RPC origins, you can ignore those for now. If that doesn't satisfy
# you, look here: https://github.com/meew0/discordrb/wiki/Redirect-URIs-and-RPC-origins
# After creating the bot, simply copy the token (*not* the OAuth2 secret) and the client ID and put it into the
# respective places.

bot = Discordrb::Commands::CommandBot.new token: 'MzExNTI1NzYwNjAxMDMwNjU2.DAWJWw.VVjwTsMsIrhRjpoZMaQ83DxL8DY', client_id: 311525760601030656, prefix: '!'

# Return into the consol (or into a log file) the url to be used to invite the bot.
puts "This bot's invite URL is #{bot.invite_url}."

# Return a help on the actions realisable by the bot.
bot.message(content: '!help') do |event|
  event.respond "Command List:\n!version: Gives you the developed version of the bot.\n!ping: Pong!\n!sweet victory: Links you to Sweet Victory\n!roulette_russe: Like a Russian Roulette you can be kick from the serveur.\n"
end

=begin
       ____________
      |            |
      |  Template  |
      |____________|

bot.message(content: '!') do |event|
  event.respond ''
end

=end

# Return the developed version of the bot.
bot.message(content: '!version') do |event|
  event.respond 'Koalazer Bot is in beta version. Use !help to know what he can do.'
end

# A implémenter de façon à passer par YouTube.
#sweet victory
bot.message(content: '!sweet victory') do |event|
  event.respond 'https://www.youtube.com/watch?v=tVm7LOHNA24'
end

# Classical 'Pong!' responded to a '!ping'
bot.message(content: '!ping') do |event|
  event.respond 'Pong!'
end

#VMO
# Russian roulet game : one chance on 6 to get kick from the server.
bot.command :roulette_russe do |event|

  channel = event.user.voice_channel
  user = event.user
  score = rand(1..6)
  bot.kick(user, channel)

  if score == 3
    #event << '/tts PAN'
    #event << '/kick ' + event.user.name
    bot.kick(user, channel)
  else
    event << "Clic"
    event << "Un autre volontaire ? :)"
  end

end

# Send a private message to the user which has mentionned Koalazer in a chat.
bot.mention do |event|
  event.user.pm('You have mentioned me!')
end

# Return the name of the user who asked this command.
bot.command :user do |event|
  # Commands send whatever is returned from the block to the channel. This allows for compact commands like this,
  # but you have to be aware of this so you don't accidentally return something you didn't intend to.
  # To prevent the return value to be sent to the channel, you can just return `nil`.
  event.user.name  
end

# Connect the bot into hte voice channel of the user who called it.
bot.command(:connect) do |event|

  channel = event.user.voice_channel

  # Case where the user who asked bot connection isn't in a voice channel.
  next "You're not in any voice channel!" unless channel

  # Case where the user who asked bot connection is in a voice channel -> connect the bot into it.
  bot.voice_connect(channel)
  "Connected to voice channel: #{channel.name}"

end

# Sympa mais à modifier pour passer par YouTube
bot.command(:play_victory) do |event|
  # `event.voice` is a helper method that gets the correct voice bot on the server the bot is currently in. Since a
  # bot may be connected to more than one voice channel (never more than one on the same server, though), this is
  # necessary to allow the differentiation of servers.
  #
  # It returns a `VoiceBot` object that methods such as `play_file` can be called on.
  voice_bot = event.voice
  voice_bot.play_file('discordrb-master/SpongeBob SquarePants Production Music - Sweet Victory 1.mp3')
end

# Does it work ?
#bot.member_join(channel) do |event, username|
#    event.respond('Welcome to the server, username')
#end

# Bot action on some chat words

#salty
bot.message(contains: 'connard') do |event|
  event.respond "Tu vas te calmer hein !"
end

=begin
#PM the bot
bot.pm(contains:' ') do |event|
    event.user.pm('I am a robot do not message me, if you have questions ask Kevin or Jason.')
end
=end

#secret
#konamicode
bot.message(content: '!up up down down left right left right B A start') do |event|
  event.respond 'Congratulations, you found a secret tag! There are still more to find. Can you find them all?'
end

# Execute the bot code and connect it into the server.
bot.run
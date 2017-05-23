=begin
Run Instructions:
command line:
$ruby Discordbot.rb
=end

require 'discordrb'
#require 'date'
#date = DateTime.now
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
# Here we output the invite URL to the console so the bot account can be invited to the channel. This only has to be
# done once, afterwards, you can remove this part if you want
puts "This bot's invite URL is #{bot.invite_url}."
puts 'Click on it to invite it to your server.'

bot.message(content: '!help') do |event|
    event.respond "Command List:\n!kelpyg: links you to Kelpy (6 hours)\n!ping: Pong!\n!ezsong: playlist of easy-listening music\n!sweet victory: Links you to Sweet Victory\n!botinfo: Tells you information about the bot\n!roulette_russe: Generates a random number between the two given numbers\n"
end

=begin
        template
bot.message(content: '!') do |event|
  event.respond ''
end
=end

#version
bot.message(content: '!version') do |event|
    event.respond 'Koalazer Bot is in beta_version'
end

#kelpy g 6 hours
bot.message(content: '!kelpyg') do |event|
  event.respond 'https://www.youtube.com/watch?v=g72A9dVV18M'
end

=begin
        template
bot.message(content: '!') do |event|
  event.respond ''
end
=end


#easy listening songs
bot.message(content: '!ezsongs') do |event|
  event.respond 'https://www.youtube.com/watch?v=dvH-nbindvk&index=1&list=PLTVjPAw118GfBbGrOva0NUDft7VmvWdUW&t=234s'
end

#sweet victory
bot.message(content: '!sweet victory') do |event|
    event.respond 'https://www.youtube.com/watch?v=tVm7LOHNA24'
end

bot.message(content: '!botinfo') do |event|
    event.respond "Hi, I'm BWMRD Bot. I was written by Jason Odell and Kevin Lane."
end

#links to date calculator until March 3rd
bot.message(content: '!switchlaunch') do |event|
  event.respond 'https://days.to/until/3-march'
end

#responds 'Pong!' to '!ping'
bot.message(content: '!ping') do |event|
  event.respond 'Pong!'
end

#secret
#konamicode
bot.message(content: '!up up down down left right left right B A start') do |event|
    event.respond 'Congratulations, you found a secret tag! There are still more to find. Can you find them all?'
end

#VMO
#Pour roulette russe
#random number generator
bot.command :roulette_russe do |event|
  score = rand(1..6)
  event << 'Le roulette tourne...'
  event << '...'
  sleep 1
  event << '..'
  sleep 1
  event << '.'
  sleep 1
  if score = 3
    event << '/tts PAN'
    event << '/kick ' + event.user.name
  else
    event << "Clic"
    event << "Un autre volontaire ? :)"
  end
end

bot.mention do |event|
  # The `pm` method is used to send a private message (also called a DM or direct message) to the user who sent the
  # initial message.
  event.user.pm('You have mentioned me!')
end


bot.command :user do |event|
  # Commands send whatever is returned from the block to the channel. This allows for compact commands like this,
  # but you have to be aware of this so you don't accidentally return something you didn't intend to.
  # To prevent the return value to be sent to the channel, you can just return `nil`.
  event.user.name  
end


bot.command(:connect) do |event|
  # The `voice_channel` method returns the voice channel the user is currently in, or `nil` if the user is not in a
  # voice channel.
  channel = event.user.voice_channel

  # Here we return from the command unless the channel is not nil (i. e. the user is in a voice channel). The `next`
  # construct can be used to exit a command prematurely, and even send a message while we're at it.
  next "You're not in any voice channel!" unless channel

  # The `voice_connect` method does everything necessary for the bot to connect to a voice channel. Afterwards the bot
  # will be connected and ready to play stuff back.
  bot.voice_connect(channel)
  "Connected to voice channel: #{channel.name}"
end


#Sympa mais à modifier pour apsser par YouTube
bot.command(:play_victory) do |event|
  # `event.voice` is a helper method that gets the correct voice bot on the server the bot is currently in. Since a
  # bot may be connected to more than one voice channel (never more than one on the same server, though), this is
  # necessary to allow the differentiation of servers.
  #
  # It returns a `VoiceBot` object that methods such as `play_file` can be called on.
  voice_bot = event.voice
  voice_bot.play_file('discordrb-master/SpongeBob SquarePants Production Music - Sweet Victory 1.mp3')
end


#Does it work ?
bot.member_join(channel) do |event, username|
    event.respond('Welcome to the server, username')
end



#salty
bot.message(contains: 'connard') do |event|
    event.respond "Tu vas te calmer hein !."
end


=begin
#PM the bot
bot.pm(contains:' ') do |event|
    event.user.pm('I am a robot do not message me, if you have questions ask Kevin or Jason.')
end
=end


# This method call has to be put at the end of your script, it is what makes the bot actually connect to Discord. If you
# leave it out (try it!) the script will simply stop and the bot will compulsively masturbate and/or not appear online.
bot.run

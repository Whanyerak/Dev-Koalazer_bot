require 'rspotify'
require 'nokogiri'
require 'youtube-dl.rb'
require_relative 'music'

# Spotify API Connect
=begin
RSpotify.authenticate(spotify_client_id, spotify_client_secret)
spot = RSpotify::User.find(spotify_user)
spot.playlists.each do |list|
	if list.name == playlist_name
		@playlist = list
		puts "Playlist set to " + @playlist.name
	end
end
=end


# bot.message(content: '!koala_play', in: discord_text_channel, from: discord_admin) do |event|
bot.message(content: '!koala_play') do |event, song_name, song_artist|

	music = Music.new();

	user_channel = event.user.voice_channel

		# Case where the user who asked bot connection isn't in a voice channel.
  	next "You're not in any voice channel!" unless user_channel

	bot_channel = bot.voice_channel
	if user_channel && user_channel != bot_channel

  		# Case where the user who asked bot connection is in a voice channel -> connect the bot into it.
  		bot.voice_connect(user_channel)
  	end

	if bot_channel != nil

		# Start playing
		event.respond 'Prepping tunes'

		music.play(song_name, song_artist)

		#music.start()
		if (music.success?)
			event.voice.play_file('song.mp3')
			event.respond 'Playing #{song_name} from #{song_artist} !'
		else
			event.respond 'Something went wrong :\\'
		end
	else
		event.respond 'You\'re not in a voice channel dude...'
	end

end
=beginrequire 'rspotify'
require 'nokogiri'
require 'youtube-dl.rb'
require_relative 'music'=end

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



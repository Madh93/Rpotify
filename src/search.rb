require_relative 'authentication'

class Search

	def initialize query
		@query = query
	end

	def bySong
		puts "song: " + @query
	end

	def byAlbum
		puts "album: " + @query
	end

	def byArtist
		puts "artist: " + @query
	end
end
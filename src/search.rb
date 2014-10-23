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

search = Search.new ARGV[2...ARGV.size].join(' ')

case ARGV[1]
	when "-s","--song" then search.bySong
	when "--album" then search.byAlbum
	when "-a","--artist" then search.byArtist
	else puts "Bad argument"
end
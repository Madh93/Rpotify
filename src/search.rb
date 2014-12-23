require_relative 'authentication'
require 'terminal-table'
require 'rspotify'
require './song.rb'

$RPOTIFY = File.expand_path("../../rpotify.sh", __FILE__)

class Search

	def initialize query
		@query = query
	end

	def bySong

		founds = RSpotify::Base.search(@query, 'track')
		max_founds = founds.size
		rows = []

		founds.each_with_index do |f,i|

			s = Song.new(f)
			rows << [i+1,s.name,s.artist,s.duration,s.popularity,s.album]
		end

		table = Terminal::Table.new :title => "Showing results for \e[1m#{@query}\e[0m", :headings => ["#","Song","Artist","Duration","Popularity","Album"], :rows => rows
		puts table
		exit if max_founds == 0

		loop do
			print "\e[1mChoose:\e[0m "
			option = STDIN.gets.chomp.to_i
			option -= 1
			exit if (option >= max_founds) || (option < 0)
			system("#{$RPOTIFY} uri string:#{founds[option].uri}")
		end
	end

	def byAlbum
		puts "album: " + @query
		#albums = RSpotify::Base.search(@query, 'album')
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
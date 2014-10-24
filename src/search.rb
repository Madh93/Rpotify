require_relative 'authentication'
require 'terminal-table'

$RPOTIFY = File.expand_path("../../rpotify.sh", __FILE__)

class Search

	def initialize query
		@query = query
	end

	def bySong

		tracks = RSpotify::Base.search(@query, 'track')
		max_founds = tracks.size
		rows = []

		tracks.each_with_index do |t,i|

			artist = t.artists[0].name
			artist + "," + t.artists[1].name if t.artists.size > 1
			min = t.duration_ms/60000
			seg = (t.duration_ms/1000)%60
			duration = min.to_s + "'" + seg.to_s + "''"
				
			rows << [i+1,t.name[0..40],artist[0..30],duration,t.popularity.to_s+"%",t.album.name[0..30]]
		end

		table = Terminal::Table.new :title => "Showing results for \e[1m#{@query}\e[0m", :headings => ["#","Song","Artist","Duration","Popularity","Album"], :rows => rows
		puts table

		while 1
			print "\e[1mChoose:\e[0m "
			option = STDIN.gets.chomp.to_i
			option -= 1
			exit if (option >= max_founds) || (option < 0)
			system("#{$RPOTIFY} uri string:#{tracks[option].uri}")
		end
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
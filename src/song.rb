
class Song

    attr_reader :name, :artist, :album, :duration, :popularity

    def initialize metadata
        @metadata = metadata
        @name = setName
        @artist = setArtist
        @album = setAlbum
        @duration = setDuration
        @popularity = setPopularity
    end

    private

    def setName
        @metadata.name[0..30]
    end

    def setArtist
        if @metadata.artists.size > 1
            "#{@metadata.artists[0].name}, #{@metadata.artists[1].name}"[0..25]
        else
            @metadata.artists[0].name[0..25]
        end     
    end

    def setAlbum
        @metadata.album.name[0..25]
    end

    def setDuration
        "#{@metadata.duration_ms/60000}'#{(@metadata.duration_ms/1000)%60}''"        
    end

    def setPopularity
        "#{@metadata.popularity}%"
    end

end
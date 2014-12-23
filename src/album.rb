
class Album

    attr_reader :name, :artist, :genres, :release, :popularity

    def initialize metadata
        @metadata = metadata
        @name = setName
        @artist = setArtist
        @genres = setGenres
        @release = setRelease
        @popularity = setPopularity
    end

    private

    def setName
        @metadata.name[0..40]
    end

    def setArtist
        if @metadata.artists.size > 1
            "#{@metadata.artists[0].name}, #{@metadata.artists[1].name}"[0..30]
        else
            @metadata.artists[0].name[0..30]
        end     
    end

    def setGenres
    end

    def setRelease
    end

    def setPopularity
        "#{@metadata.popularity}%"
    end

end
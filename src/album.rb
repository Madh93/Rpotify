
class Album

    attr_reader :name, :artist, :genres, :released, :popularity

    def initialize metadata
        @metadata = metadata
        @name = setName
        @artist = setArtist
        @genres = setGenres
        @released = setReleased
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

    def setGenres
        if @metadata.genres.size > 1
            "#{@metadata.genres[0]}, #{@metadata.genres[1]}"[0..20]
        else
            @metadata.genres[0]
        end
    end

    def setReleased
        @metadata.release_date.split('-')[0]
    end

    def setPopularity
        "#{@metadata.popularity}%"
    end

end
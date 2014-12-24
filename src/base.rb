
class Base

    attr_reader :name, :popularity, :artist, :album, :duration, :genres, :released

    def initialize metadata, type
        @metadata = metadata
        @name = setName
        @popularity = setPopularity
        @artist, @album, @duration, @genres, @released = nil

        case type
            when Song then setArtist; setAlbum; setDuration
            when Album then setArtist; setGenres; setReleased
            when Artist then setGenres
        end
    end

    private

    def setName
        @metadata.name[0..30]
    end

    def setPopularity
        "#{@metadata.popularity}%"
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

end
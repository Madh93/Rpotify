
class Base

    attr_reader :name, :popularity, :artist, :album, :duration, :genres, :released

    def initialize metadata, type
        @metadata = metadata
        @name = setName
        @popularity = setPopularity
        @artist, @album, @duration, @genres, @released = nil

        case
            when type == Song then setArtist; setAlbum; setDuration
            when type == Album then setArtist; setGenres; setReleased
            when type == Artist then setGenres
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
            @artist = "#{@metadata.artists[0].name}, #{@metadata.artists[1].name}"[0..25]
        else
            @artist = @metadata.artists[0].name[0..25]
        end     
    end

    def setAlbum
        @album = @metadata.album.name[0..25]
    end

    def setDuration
        @duration = "#{@metadata.duration_ms/60000}'#{(@metadata.duration_ms/1000)%60}''"        
    end


    def setGenres
        if @metadata.genres.size > 1
            @genres = "#{@metadata.genres[0]}, #{@metadata.genres[1]}"[0..20]
        else
            @genres = @metadata.genres[0]
        end
    end

    def setReleased
        @released = @metadata.release_date.split('-')[0]
    end    

end
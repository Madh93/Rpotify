
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
    end

    def setArtist
    end

    def setAlbum
    end

    def setDuration
    end

    def setPopularity
    end

end

class Artist

    attr_reader :name, :genres, :popularity

    def initialize metadata
        @metadata = metadata
        @name = setName
        @genres = setGenres
        @popularity = setPopularity
    end

    private

    def setName
        @metadata.name[0..30]
    end

    def setGenres
        if @metadata.genres.size > 1
            "#{@metadata.genres[0]}, #{@metadata.genres[1]}"[0..20]
        else
            @metadata.genres[0]
        end
    end    

    def setPopularity
        "#{@metadata.popularity}%"
    end

end
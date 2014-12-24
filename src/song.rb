require_relative 'base'

class Song < Base

    def initialize metadata
        super(metadata,self.class)
    end
end
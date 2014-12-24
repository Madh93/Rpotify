require_relative 'base'

class Album < Base

    def initialize metadata
        super(metadata,self.class)
    end
end
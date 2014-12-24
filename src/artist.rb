require_relative 'base'
 
class Artist < Base

    def initialize metadata
        super(metadata,self.class)
    end
end
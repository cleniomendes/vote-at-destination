class DestinationController < ApplicationController
    def index 
        @destinations = Destination.order("RANDOM()").limit(2)
    end
end

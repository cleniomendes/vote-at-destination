class VoteController < ApplicationController
    def vote
        arr_dt = []
        @destinations = Destination.order("RANDOM()").limit(2)
        @destinations.each {|dt| arr_dt.push(dt.id)}
        cookies[:found_destinations] = arr_dt.join(",").to_s
        render :template => "vote/vote"
    end
    
    def first_vote
        unless params[:destination_id].nil?
            cookies[:destination] = params[:destination_id]
            @destinations = Destination.where.not(id: cookies[:found_destinations].split(",")) 
            render :template => 'vote/keep_voting'
        else
            flash[:error] = "Please, Choose at least one destination"
            redirect_to root_path
        end
    end
end
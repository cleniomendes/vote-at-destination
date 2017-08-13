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
            cookies[:vote_0] = params[:destination_id]
            @destinations = Destination.where.not(id: cookies[:found_destinations].split(",")) 
            render :template => 'vote/keep_voting'
        else
            flash[:error] = "Please, Choose at least one destination"
            redirect_to root_path
        end
    end
    
    def keep_voting
        unless params[:destination_id].nil?
            cookies[:vote_1] = params[:destination_id]
            redirect_to new_user_path
        else
            flash[:error] = "Please, Choose at least one destination"
            @destinations = Destination.where.not(id: cookies[:found_destinations].split(",")) 
            render :template => 'vote/keep_voting'
        end
    end
    
    def finish_poll
        2.times do |i| 
            cookie_value = "vote_#{i}"
            @vote = Vote.new(:destination_id => cookies[cookie_value], :user_id => params['param1'])
            unless @vote.save
                flash[:error] = "If you not choose destination, you can't continue"
                redirect_to root_path and return
            end
        end
        redirect_to root_path, notice: "Vote accomplished successfully!"
    end
end
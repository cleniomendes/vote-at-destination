Rails.application.routes.draw do
   root :to => "vote#vote"
   post 'vote', :to => 'vote#first_vote', :as => "first_vote"
   post 'vote/keep_voting', :to => "vote#keep_voting", :as => "keep_voting"
end

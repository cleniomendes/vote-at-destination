Rails.application.routes.draw do
   root :to => "vote#vote"
   post 'vote', :to => 'vote#first_vote', :as => "first_vote"
end

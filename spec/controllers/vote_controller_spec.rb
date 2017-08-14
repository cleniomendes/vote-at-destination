require 'rails_helper'

RSpec.describe VoteController, type: :controller do
    describe "GET #index" do
        it "list max two random destinations" do
            ["Rio De Janeiro","São Paulo","Minas Gerais"].each do |c|
                create(:destination, :name => c)
            end
            
            get :vote
            puts response.body
            expect(assigns(:destinations).length).to eq(2)
        end
        
        it "list a destination" do
            destination = create(:destination)
            get :vote
            expect(assigns(:destinations).should).to eq [destination]
        end
      
        it "renders the :vote view" do
            get :vote
            expect(response.should).to render_template ('vote/vote')
        end
    end
    
    describe "#Post first vote" do
        it "set value cookie with param" do
            params = {
                destination:{
                    destination_id: 1
                }
            }
            request.cookies[:found_destinations] = "1,2"
            
            post :first_vote
            expect(request.cookies[:destination]).to eq(params[:destination_id])
        end
        
        it "return the correct count others destinations to vote" do
            ["Rio De Janeiro","São Paulo","Olinda","Belo Horizonte"].each do |c|
                create(:destination, :name => c)
            end
            
            request.cookies[:found_destinations] = "1,2"
            
            post :first_vote, :params => {destination_id: 1}
            expect(assigns(:destinations).length).to eq(Destination.count - 2)
        end
        
        it "when return flash message if no params" do 
            post :first_vote, :params => {}
            expect(flash[:error]).to be_present
        end
    end
    
    describe "#Post keep voting" do
        it "when value cookie has param" do
            params = {
                destination_id: 1    
            }
            post :keep_voting, :params => params
            expect(response.should).to redirect_to :new_user
            
        end
        
        it "when return flash message if no params" do 
            request.cookies[:found_destinations] = "1,2"
            post :keep_voting, :params => {}
            expect(response.should).to render_template("vote/keep_voting")
            expect(flash[:error]).to be_present
        end
    end
    
    describe "#Post finish_poll" do 
        before do 
            create(:user)
            ["Rio De Janeiro","São Paulo"].each do |c|
                create(:destination, :name => c)
            end
        end
    
        it "when vote went successfully add" do 
            params = {:param1 => 1}
            request.cookies[:vote_0] = "1"
            request.cookies[:vote_1] = "2"
            post :finish_poll, :params => params
            expect(response).to redirect_to(show_path(:param1 => 1))
            expect(Vote.count).to eq (2)
        end
    end
    
    describe "#Get show results" do
        before do 
            create(:user)
            ["Rio De Janeiro","São Paulo"].each do |c|
                create(:destination, :name => c)
            end
        end
        
        it "show all and user vote" do 
            params = {:param1 => 1}
            get :show_results, :params => params
            expect(response).to render_template 'vote/show'
        end
    end
end

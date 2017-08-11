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
            destination = create(:destination)
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
    end
end
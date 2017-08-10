require 'rails_helper'

RSpec.describe DestinationController, type: :controller do
    describe "GET #index" do
        it "list max two random destinations" do
            ["Rio De Janeiro","São Paulo","Minas Gerais"].each do |c|
                create(:destination, :name => c)
            end
            
            get :index
            puts response.body
            expect(assigns(:destinations).length).to eq(2)
        end
        
        it "list a destination" do
            destination = create(:destination)
            get :index
            expect(assigns(:destinations).should).to eq [destination]
        end
      
        it "renders the :index view" do
            destination = create(:destination)
            get :index
            expect(response.should).to render_template :index
        end
    end
end

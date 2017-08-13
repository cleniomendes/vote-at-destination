require 'rails_helper'

RSpec.describe UserController, type: :controller do
    describe "GET #new" do
        it "assigns the requested user to @user" do
            get :new
            expect(assigns(:user)).to be_a_new(User)
        end
        
        it "renders the template" do
            get :new
            expect(response.should).to render_template 'vote/confirm_vote'
        end
    end
    
    describe "POST #create" do
        context "with valid attributes" do
            let(:user_params) {
                {
                user:{
                    name: "Clenio",
                    email: "clenio.si@gmail.com"
                }
                }
            }
            it "permit the params request" do
                expect(subject).to permit(:name,:email).for(:create, params: { params: user_params }).on(:user)
            end
            it { assigns(:user) }
            subject{ response.code }
            it { should respond_to?("200") } 
            before { post :create, :params => user_params }
            it { should redirect_to(finish_poll_path(:param1 => 1)) } 
        end
        
        context "with invalid attributes" do 
            it "does not save the new user" do
                expect{
                    post :create, params: { user: FactoryGirl.attributes_for(:invalid_user) } 
                }.to_not change(User,:count)
            end
            
            it "re-renders the new template" do
              post :create, params: { user: FactoryGirl.attributes_for(:invalid_user) } 
              expect(response.should).to render_template 'vote/confirm_vote'
            end
        end
    end
end

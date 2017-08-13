require 'rails_helper'

RSpec.feature "ConfirmVotes", type: :feature do
        describe "should confirm vote" do
            before do 
                ["Rio De Janeiro","São Paulo","Recife"].each do |c|
                    create(:destination, :name => c)
                end
                
                page.driver.browser.set_cookie("vote_0=1")
                page.driver.browser.set_cookie("vote_1=2")
            end
        
        it "should create a new user after confirm" do
            visit new_user_path
            
            within "#confirm_vote" do
                fill_in 'Name', :with => 'Clenio'
                fill_in 'Email', :with => 'clenio.si@gmail.com'
            end
            
            click_link_or_button "Finish Vote"
            
            expect(User.count).to eq(1)
            expect(Vote.count).to eq(2)
        end
    end
end


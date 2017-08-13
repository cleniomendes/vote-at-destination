require 'rails_helper'

RSpec.feature "Votes", type: :feature do
    describe "list options poll" do
        before do 
            ["Rio De Janeiro","São Paulo","Recife"].each do |c|
                create(:destination, :name => c)
            end
        end
        it "choose vote" do
            params = {}
            visit root_path
            
            within "#vote" do
                page.all("input").each do |s|
                    choose(s[:id])
                    params[:destination_id] = s[:value]
                    break
                end
            end
            
            click_link_or_button "Vote"
            expect(page.driver.browser.set_cookie(params[:destination_id])).to eq([params[:destination_id]])
        end
    end
end

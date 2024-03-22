require 'rails_helper'

RSpec.describe 'Movies show' do
    before(:each) do
        @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
        @user1 = User.create!(name: 'Sam', email: 'sam@email.com')
    end
    
    it 'allows user to see movie details',:vcr do
        
        visit user_discover_index_path(@user)
        click_button("Top Rated Movies")
        
        first('.title a').click

        expect(page).to have_link("Discover Page")

        expect(page).to have_css(".Title")
        expect(page).to have_css(".vote")
        expect(page).to have_css(".Runtime")
        expect(page).to have_css(".Genres")
        expect(page).to have_css(".Summary")
        expect(page).to have_css(".Cast")
        expect(page).to have_css(".review")
        expect(page).to have_css(".author")
        expect(page).to have_css(".review")

    expect(page).to have_link("Create Viewing Party")
    
    end
end
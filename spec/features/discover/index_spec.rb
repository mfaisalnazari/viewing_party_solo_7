require 'rails_helper'

RSpec.describe 'Discover' do
    before(:each) do
        @user = User.create!(name: 'Tommy', email: 'tommy@email.com')
        @user1 = User.create!(name: 'Sam', email: 'sam@email.com')
    end
    
    it 'allows user to get top rated movies',:vcr do
        visit user_discover_index_path(@user)
        expect(page).to have_button("Top Rated Movies")

        click_button("Top Rated Movies")
        
        expect(current_path).to eq(user_movies_path(@user))
        expect(page).to have_css(".movie", count: 20)
       
        within(first(".movie")) do
            expect(page).to have_css(".title")
            expect(page).to have_css(".vote")

            
          end
        expect(page).to have_link("Discover Page")
        click_link("Discover Page")

        expect(current_path).to eq(user_discover_index_path(@user))

    end

    it 'allows user to search for movie',:vcr do
        visit user_discover_index_path(@user)
        
      fill_in :search, with: 'Kung Fu Panda 4'
      click_button 'Search'

        expect(current_path).to eq(user_movies_path(@user))
        expect(page).to have_css(".title")
        expect(page).to have_css(".vote")

        expect(page).to have_link("Discover Page")
        click_link("Discover Page")

        expect(current_path).to eq(user_discover_index_path(@user))
    end
    
end
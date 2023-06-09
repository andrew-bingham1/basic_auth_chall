require 'rails_helper'

RSpec.describe 'Movies Details Page', type: :feature do
  describe 'User Story #10', :vcr do
    before (:each) do
      @user1 = User.create!(name: 'John Doe', email: 'johndoe@yahoo.com')
      @user2 = User.create!(name: 'Jane Doe', email: 'janedoe@yahoo.com')
    end

    it 'exists' do
      visit user_movie_path(@user1, 238)

      expect(current_path).to eq(user_movie_path(@user1, 238))

      visit user_movie_path(@user2, 100)

      expect(current_path).to eq(user_movie_path(@user2, 100))
    end

    it 'displays button to create viewing party' do
      visit user_movie_path(@user1, 238)
      expect(page).to have_button('Create Viewing Party')
      click_button 'Create Viewing Party'
      expect(current_path).to eq(user_new_viewing_party_path(@user1, 238))
    end

    it "displays a button to return to discover page" do
      visit user_movie_path(@user1, 238)
      expect(page).to have_button('Discover Page')
      click_button 'Discover Page'
      expect(current_path).to eq(user_discover_path(@user1))
    end

    it 'displays movie title' do
      visit user_movie_path(@user1, 100)

      within('#title') do
        expect(page).to have_content('Lock, Stock and Two Smoking Barrels')
        expect(page).to_not have_content('The Godfather')
      end
      
      visit user_movie_path(@user2, 238)

      within('#title') do
        expect(page).to have_content('The Godfather')
        expect(page).to_not have_content('Lock, Stock and Two Smoking Barrels')
      end
    end

    it 'shows movies info (vote average, runtime, genres)' do
      visit user_movie_path(@user1, 100)

      within('#movie-info') do
        expect(page).to have_content('Vote: 8.1')
        expect(page).to have_content('Runtime: 1 hour(s) and 45 minutes')
        expect(page).to have_content('Genre(s): Comedy Crime')
        expect(page).to_not have_content('Vote: 8.7')
        expect(page).to_not have_content('Runtime: 2 hour(s) and 55 minutes')
        expect(page).to_not have_content('Genre(s): Drama Crime')
      end

      visit user_movie_path(@user2, 238)

      within('#movie-info') do
        expect(page).to have_content('Vote: 8.7')
        expect(page).to have_content('Runtime: 2 hour(s) and 55 minutes')
        expect(page).to have_content('Genre(s): Drama Crime')
        expect(page).to_not have_content('Vote: 8.1')
        expect(page).to_not have_content('Runtime: 1 hour(s) and 45 minutes')
        expect(page).to_not have_content('Genre(s): Comedy Crime')
      end

    end

    it 'shows movies summary' do
      visit user_movie_path(@user1, 238)

      within('#summary') do
        expect(page).to have_content('Summary:')
        expect(page).to have_content('Spanning the years 1945 to 1955')
        expect(page).to_not have_content('A card shark and his unwillingly-enlisted friends')
      end

      visit user_movie_path(@user2, 100)

      within('#summary') do
        expect(page).to have_content('Summary:')
        expect(page).to have_content('A card shark and his unwillingly-enlisted friends')
        expect(page).to_not have_content('Spanning the years 1945 to 1955')
      end
    end

    it 'shows cast members' do
      visit user_movie_path(@user1, 238)

      within('#cast') do
        expect(page).to have_content('Cast:')
        expect(page).to have_content('Marlon Brando')
        expect(page).to have_content('Al Pacino')
        expect(page).to have_content('James Caan')
        expect(page).to have_content('Robert Duvall')
        expect(page).to have_content('Diane Keaton')
        expect(page).to_not have_content('Jason Flemyng')
        expect(page).to_not have_content('Dexter Fletcher')
        expect(page).to_not have_content('Nick Moran')
        expect(page).to_not have_content('Jason Statham')
        expect(page).to_not have_content('Steven Mackintosh')
      end

      visit user_movie_path(@user2, 100)

      within('#cast') do
        expect(page).to have_content('Cast:')
        expect(page).to have_content('Jason Flemyng')
        expect(page).to have_content('Dexter Fletcher')
        expect(page).to have_content('Nick Moran')
        expect(page).to have_content('Jason Statham')
        expect(page).to have_content('Steven Mackintosh')
        expect(page).to_not have_content('Marlon Brando')
        expect(page).to_not have_content('Al Pacino')
        expect(page).to_not have_content('James Caan')
        expect(page).to_not have_content('Robert Duvall')
        expect(page).to_not have_content('Diane Keaton')
      end
    end

    it 'shows reviews' do
      visit user_movie_path(@user1, 100)

      within('#reviews') do
        expect(page).to have_content('4 Reviews:')
        expect(page).to have_content('Reviewer: BradFlix')
        expect(page).to have_content('I just plain love this movie!')
        expect(page).to_not have_content('Reviewer: futuretv')
        expect(page).to_not have_content('The Godfather Review by Al Carlson')
      end

      visit user_movie_path(@user2, 238)

      within('#reviews') do
        expect(page).to have_content('3 Reviews:')
        expect(page).to have_content('Reviewer: futuretv')
        expect(page).to have_content('The Godfather Review by Al Carlson')
        expect(page).to_not have_content('Reviewer: BradFlix')
        expect(page).to_not have_content('I just plain love this movie!')
      end
    end
  end
end
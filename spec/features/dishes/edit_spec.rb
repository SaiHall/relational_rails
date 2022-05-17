require 'rails_helper'

RSpec.describe "dishes edit page", type: :feature do
  before(:each) do
    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
  end
  describe 'Dish update: Show page' do
    it 'has a link to the update page from the show page' do
      visit "/dishes/#{@fry_pickle.id}"

      click_link("Update Dish")

      expect(page).to have_current_path("/dishes/#{@fry_pickle.id}/edit")
    end

    it 'has a form that can be filled out to update a restaurant entry' do
      visit("/dishes/#{@fry_pickle.id}/edit")

      fill_in 'Name', with: "Fried Cauliflower"
      choose :in_season, with: false #radio button
      fill_in 'Cost', with: '11'

      click_button("Update Dish")

      expect(page).to have_current_path("/dishes/#{@fry_pickle.id}")
      expect(page).to have_content("Fried Cauliflower")
      expect(page).to have_content("Currently in season: false")
      expect(page).to have_content("Cost: $11")
    end
  end
  describe 'Dish update: index page' do #do I need different tests for these?
    it 'has a link to the update page from the show page' do
      visit "/dishes/"

      click_link("Update Fried Pickles")

      expect(page).to have_current_path("/dishes/#{@fry_pickle.id}/edit")
    end

    it 'has a form that can be filled out to update a restaurant entry' do
      visit("/dishes")

      click_link("Update Fried Pickles")

      fill_in 'Name', with: "Fried Cauliflower"
      choose :in_season, with: false #radio button
      fill_in 'Cost', with: '11'

      click_button("Update Dish")

      expect(page).to have_current_path("/dishes/#{@fry_pickle.id}")
      expect(page).to have_content("Fried Cauliflower")
      expect(page).to have_content("Currently in season: false")
      expect(page).to have_content("Cost: $11")
    end
  end
end

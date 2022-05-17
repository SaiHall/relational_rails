require 'rails_helper'

RSpec.describe "restaurants new page", type: :feature do
  describe 'New restaurant creation' do
    it 'has a link that leads to a page to create a new restaurant' do
      visit "/restaurants"

      click_link("New Restaurant")

      expect(page).to have_current_path("/restaurants/new")
    end

    it 'has a form to create a new restaurant, creates a restaurant when submitted, and redirects to index' do
      visit "/restaurants/new"

      fill_in 'Name', with: "Canadian Cranberry Caravan"
      choose :open, with: false #radio button
      fill_in 'Guest capacity', with: '25'

      click_button("Create Restaurant")

      expect(page).to have_current_path("/restaurants")
      expect(page).to have_content("Canadian Cranberry Caravan")
    end
  end
end

require 'rails_helper'

RSpec.describe "restaurants edit page", type: :feature do
  before(:each) do
    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
  end
  describe 'Restaurant update' do
    it 'has a link to the update page from the show page' do
      visit "/restaurants/#{@billy.id}"

      click_link("Update #{@billy.name}")

      expect(page).to have_current_path("/restaurants/#{@billy.id}/edit")
    end
  end
end

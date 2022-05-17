require 'rails_helper'

RSpec.describe "restaurants edit page", type: :feature do
  before(:each) do
    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
    @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
    @banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
  end
  describe 'Restaurant update' do
    it 'has a link to the update page from the show page' do
      visit "/restaurants/#{@billy.id}"

      click_link("Update #{@billy.name}")

      expect(page).to have_current_path("/restaurants/#{@billy.id}/edit")
    end

    it 'has a form that can be filled out to update a restaurant entry and returns to show' do
      visit("/restaurants/#{@billy.id}/edit")

      fill_in 'Name', with: "William's BBQ Bodega"
      choose :open, with: false #radio button
      fill_in 'Guest capacity', with: '55'

      click_button("Update Restaurant")

      expect(page).to have_current_path("/restaurants/#{@billy.id}")
      expect(page).to have_content("William's BBQ Bodega")
      expect(page).to have_content("Open for business: false")
      expect(page).to have_content("Capacity: 55")
      # expect(@billy.created_at).to_not eq(@billy.updated_at) Why does updated at not change?
    end
  end

  describe 'Restaurant update from index' do
    it 'Index has a link that leads to a form that can be filled out to update a restaurant entry' do
      visit("/restaurants")

      click_link("Update Billy's BBQ Bodega")

      fill_in 'Name', with: "William's BBQ Bodega"
      choose :open, with: false #radio button
      fill_in 'Guest capacity', with: '55'

      click_button("Update Restaurant")

      expect(page).to have_current_path("/restaurants/#{@billy.id}")
      expect(page).to have_content("William's BBQ Bodega")
      # expect(@billy.created_at).to_not eq(@billy.updated_at) Why does updated at not change?
    end
  end
end

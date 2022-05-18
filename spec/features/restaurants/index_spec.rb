require 'rails_helper'

RSpec.describe "restaurants index page", type: :feature do
  before(:each) do
    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
    @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
    @banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
    visit "/restaurants"
  end

  it "can see all restaurant names" do

    expect(page).to have_content(@billy.name)
    expect(page).to have_content(@flapjack.name)
  end

  it 'displays when a restaurant was created' do

    expect(page).to have_content(@billy.created_at)
    expect(page).to have_content(@flapjack.created_at)
  end

  it 'displays restaurants in the descending order from when they were created' do
    within '#restaurantIndex' do
      expect(page.all('.restaurant')[0]).to have_content("Flapjack's")
      expect(page.all('.restaurant')[1]).to have_content("Billy's BBQ Bodega")
    end
  end

  it 'has a link to delete the restaurant' do
    visit "/restaurants"

    expect(page).to have_content("Billy's BBQ Bodega")

    click_link("Delete Billy's BBQ Bodega")

    expect(page).to have_current_path("/restaurants")
    expect(page).to_not have_content("Billy's BBQ Bodega")
    expect(page).to have_content("Flapjack's")
  end

  describe 'Functioning links' do
    it 'has a working link to the dishes index' do
      visit "/restaurants"
      expect(page).to have_content("All Dishes")
      click_on('All Dishes')
      expect(page).to have_current_path("/dishes")
      expect(page).to have_content("Fried Pickles")
    end

    it 'has a working link to the restaurants index' do
      visit "/restaurants"

      expect(page).to have_content("All Restaurants")
      click_on('All Restaurants')

      expect(page).to have_current_path("/restaurants")
      expect(page).to have_content("Flapjack's")
    end

    it 'has working links to the edit page' do
      visit "/restaurants"

      click_link("Update Billy's BBQ Bodega")

      expect(page).to have_current_path("/restaurants/#{@billy.id}/edit")

      visit "/restaurants"

      click_link("Update Flapjack's")

      expect(page).to have_current_path("/restaurants/#{@flapjack.id}/edit")
    end
  end
end

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
  end

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

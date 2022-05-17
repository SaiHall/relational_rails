require 'rails_helper'

RSpec.describe "Dishes index page", type: :feature do
  before(:each) do
    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
    @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
    @banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: true, cost: 5)
  end

  it 'can list all dishes in database, as well as their details' do

    visit "/dishes"

    expect(page).to have_content("Fried Pickles")
    expect(page).to have_content("Currently in season: true")
    expect(page).to have_content("Cost: $8")
    expect(page).to have_content("Added on: #{@fry_pickle.created_at}")
    expect(page).to have_content("Last updated at: #{@fry_pickle.updated_at}")
    expect(page).to have_content("Banana Pudding")
    expect(page).to have_content("Currently in season: true")
    expect(page).to have_content("Cost: $5")
    expect(page).to have_content("Added on: #{@banana_pud.created_at}")
    expect(page).to have_content("Last updated at: #{@banana_pud.updated_at}")
  end

  it 'only shows in_season dishes' do
    @waffle = @flapjack.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)
    visit "/dishes"

    expect(page).to_not have_content("Belgian Bonanza")
    expect(page).to_not have_content("Currently in season: false")
    expect(page).to_not have_content("Cost: $13")

  end


  describe 'Functioning links' do
    it 'has a working link to the dishes index' do
      visit "/dishes"
      expect(page).to have_content("All Dishes")
      click_on('All Dishes')
      expect(page).to have_current_path("/dishes")
      expect(page).to have_content("Fried Pickles")
    end

    it 'has a working link to the restaurants index' do
      visit "/dishes"
      expect(page).to have_content("All Restaurants")
      click_on('All Restaurants')
      expect(page).to have_current_path("/restaurants")
      expect(page).to have_content("Flapjack's")
    end
  end
end

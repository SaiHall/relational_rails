require 'rails_helper'

RSpec.describe "restaurants show page", type: :feature do
  before(:each) do
    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
    @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
    @banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
  end
  it 'can display a restaurant by id, including attributes'do

    visit "/restaurants/#{@billy.id}"

    expect(page).to have_content(@billy.name)
    expect(page).to have_content("Capacity: 35")
    expect(page).to have_content("Open for business: true")
    expect(page).to have_content("Created at: #{@billy.created_at}")
    expect(page).to have_content("Last updated: #{@billy.updated_at}")

    visit "/restaurants/#{@flapjack.id}"
    expect(page).to have_content(@flapjack.name)
    expect(page).to have_content("Capacity: 105")
    expect(page).to have_content("Open for business: true")
    expect(page).to have_content("Created at: #{@flapjack.created_at}")
    expect(page).to have_content("Last updated: #{@flapjack.updated_at}")
  end

  it 'can display the number of dishes associated with the restaurant' do
    visit "/restaurants/#{@billy.id}"
    expect(page).to have_content("Total Dishes: 1")
    chicken_wing = @billy.dishes.create!(name: "Chicken Wings", in_season: true, cost: 12)
    visit "/restaurants/#{@billy.id}"
    expect(page).to have_content("Total Dishes: 2")
  end

  describe 'Functioning links' do
    it 'has a working link to the dishes index' do
      visit "/restaurants/#{@billy.id}"
      expect(page).to have_content("All Dishes")
      click_on('All Dishes')
      expect(page).to have_current_path("/dishes")
      expect(page).to have_content("Fried Pickles")
    end

    it 'has a working link to the restaurants index' do
      visit "/restaurants/#{@billy.id}"

      expect(page).to have_content("All Restaurants")

      click_on('All Restaurants')

      expect(page).to have_current_path("/restaurants")
      expect(page).to have_content("Flapjack's")
    end

    it 'has a working link to that restaurants specific dish page' do
      visit "/restaurants/#{@billy.id}"
      expect(page).to have_content("#{@billy.name}'s Menu")
      click_link("#{@billy.name}'s Menu")
      expect(page).to have_current_path("/restaurants/#{@billy.id}/dishes")
    end
  end
end

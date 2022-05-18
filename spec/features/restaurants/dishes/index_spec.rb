require 'rails_helper'

RSpec.describe 'Specific restaurant dishes index', type: :feature do
  before(:each) do

    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
    @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
    @banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
  end

  it 'can display all dishes a particular restaurant has, and that dishes attributes' do
    visit "/restaurants/#{@billy.id}/dishes"

    expect(page).to have_content("Fried Pickles")
    expect(page).to have_content("Currently in season: true")
    expect(page).to have_content("Cost: $8")
    expect(page).to have_content("Added on: #{@fry_pickle.created_at}")
    expect(page).to have_content("Last updated at: #{@fry_pickle.updated_at}")
  end

  it 'displays dishes in alphabetical order' do
    toast = @billy.dishes.create!(name: "Texas-style Toast", in_season: false, cost: 6)
    ribs = @billy.dishes.create!(name: "Ribs - Bone-in", in_season: true, cost: 17)

    visit "/restaurants/#{@billy.id}/dishes"

    within '#restaurantDishesIndex' do
      expect(page.all('.dishes')[0]).to have_content("Fried Pickles")
      expect(page.all('.dishes')[1]).to have_content("Texas-style Toast")
      expect(page.all('.dishes')[2]).to have_content("Ribs - Bone-in")
    end

    click_link("Sort Dishes Alphabetically")

    within '#restaurantDishesIndex' do
      expect(page.all('.dishes')[0]).to have_content("Fried Pickles")
      expect(page.all('.dishes')[1]).to have_content("Ribs - Bone-in")
      expect(page.all('.dishes')[2]).to have_content("Texas-style Toast")
    end
  end

  it 'has a form for inputting a number to filter results' do
    waffle = @billy.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)
    sunrise = @billy.dishes.create!(name: "Sunrise Cider-cakes", in_season: true, cost: 15)
    visit "/restaurants/#{@billy.id}/dishes"

    expect(page).to have_content("Fried Pickles")
    expect(page).to have_content("Belgian Bonanza")
    expect(page).to have_content("Sunrise Cider-cakes")

    fill_in('value', with: 10)

    click_button "Only return records with more than 'number' of 'cost'"

    expect(page.current_path).to eq("/restaurants/#{@billy.id}/dishes")
    expect(page).to_not have_content("Fried Pickles")
    expect(page).to have_content("Belgian Bonanza")
    expect(page).to have_content("Sunrise Cider-cakes")
  end

  # it 'can both sort alphabetically and filter by number, alphabet first' do
  #   waffle = @billy.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)
  #   sunrise = @billy.dishes.create!(name: "Sunrise Cider-cakes", in_season: true, cost: 15)
  #   toast = @billy.dishes.create!(name: "Texas-style Toast", in_season: false, cost: 6)
  #   ribs = @billy.dishes.create!(name: "Ribs - Bone-in", in_season: true, cost: 17)
  #   visit "/restaurants/#{@billy.id}/dishes"
  #
  #   click_link("Sort Dishes Alphabetically")
  #
  #   within '#restaurantDishesIndex' do
  #     expect(page.all('.dishes')[0]).to have_content("Belgian Bonanza")
  #     expect(page.all('.dishes')[1]).to have_content("Fried Pickles")
  #     expect(page.all('.dishes')[2]).to have_content("Ribs - Bone-in")
  #     expect(page.all('.dishes')[3]).to have_content("Sunrise Cider-cakes")
  #     expect(page.all('.dishes')[4]).to have_content("Texas-style Toast")
  #   end
  #
  #   fill_in('value', with: 10)
  #
  #   click_button "Only return records with more than 'number' of 'cost'"
  #
  #   expect(page.current_path).to eq("/restaurants/#{@billy.id}/dishes")
  #   expect(page).to_not have_content("Fried Pickles")
  #   expect(page).to_not have_content("Texas-style Toast")
  #   expect(page).to have_content("Belgian Bonanza")
  #   expect(page).to have_content("Sunrise Cider-cakes")
  #   expect(page).to have_content("Ribs - Bone-in")
  #
  #   within '#restaurantDishesIndex' do
  #     expect(page.all('.dishes')[0]).to have_content("Belgian Bonanza")
  #     expect(page.all('.dishes')[1]).to have_content("Ribs - Bone-in")
  #     expect(page.all('.dishes')[2]).to have_content("Sunrise Cider-cakes")
  #   end
  # end
  #
  # it 'can both sort alphabetically and filter by number, threshold first' do
  #   waffle = @billy.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)
  #   sunrise = @billy.dishes.create!(name: "Sunrise Cider-cakes", in_season: true, cost: 15)
  #   toast = @billy.dishes.create!(name: "Texas-style Toast", in_season: false, cost: 6)
  #   ribs = @billy.dishes.create!(name: "Ribs - Bone-in", in_season: true, cost: 17)
  #   visit "/restaurants/#{@billy.id}/dishes"
  #
  #   fill_in('value', with: 10)
  #
  #   click_button "Only return records with more than 'number' of 'cost'"
  #
  #   expect(page.current_path).to eq("/restaurants/#{@billy.id}/dishes")
  #   expect(page).to_not have_content("Fried Pickles")
  #   expect(page).to_not have_content("Texas-style Toast")
  #   expect(page).to have_content("Belgian Bonanza")
  #   expect(page).to have_content("Sunrise Cider-cakes")
  #   expect(page).to have_content("Ribs - Bone-in")
  #
  #   click_link("Sort Dishes Alphabetically")
  #
  #   expect(page).to_not have_content("Fried Pickles")
  #   expect(page).to_not have_content("Texas-style Toast")
  #   expect(page).to have_content("Belgian Bonanza")
  #   expect(page).to have_content("Sunrise Cider-cakes")
  #   expect(page).to have_content("Ribs - Bone-in")
  #
  #   within '#restaurantDishesIndex' do
  #     expect(page.all('.dishes')[0]).to have_content("Belgian Bonanza")
  #     expect(page.all('.dishes')[1]).to have_content("Ribs - Bone-in")
  #     expect(page.all('.dishes')[2]).to have_content("Sunrise Cider-cakes")
  #   end
  # end

  describe 'Functioning links' do
    it 'has a working link to the dishes index' do
      visit "/restaurants/#{@billy.id}/dishes"
      expect(page).to have_content("All Dishes")
      click_on('All Dishes')

      expect(page).to have_current_path("/dishes")
      expect(page).to have_content("Fried Pickles")
    end

    it 'has a working link to the restaurants index' do
      visit "/restaurants/#{@billy.id}/dishes"
      expect(page).to have_content("All Restaurants")
      click_on('All Restaurants')
      expect(page).to have_current_path("/restaurants")
      expect(page).to have_content("Flapjack's")
      expect(page).to have_content("Billy's BBQ Bodega")
    end

    it 'has working links to the dish edit page' do
      visit "/restaurants/#{@billy.id}/dishes"

      click_link("Update Fried Pickles")

      expect(page).to have_current_path("/dishes/#{@fry_pickle.id}/edit")

      visit "/restaurants/#{@flapjack.id}/dishes"

      click_link("Update Banana Pudding")

      expect(page).to have_current_path("/dishes/#{@banana_pud.id}/edit")
    end
  end
end

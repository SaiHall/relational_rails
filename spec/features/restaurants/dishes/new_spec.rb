require 'rails_helper'

RSpec.describe "Restaurant specific new dish page", type: :feature do
  before(:each) do
    @canada = Restaurant.create!(name: "Canadian Cranberry Caravan", open: false, guest_capacity: 25)
    # @sunrise = Dish.create!(name: "Sunrise Cider-cakes", in_season: true, cost: 15)
  end
  it 'has a link to add a new dish from the rest/dish show page' do
    visit "/restaurants/#{@canada.id}/dishes"

    click_link("Create Dish")

    expect(page).to have_current_path("/restaurants/#{@canada.id}/dishes/new")
  end

  it 'has a form for creating a new dish associated with restaurant' do
    visit("/restaurants/#{@canada.id}/dishes/new")

    fill_in :name, with: "Sunrise Cider-cakes"
    choose :in_season, with: true
    fill_in :cost, with: "15"

    click_button("Create Dish")

    expect(page).to have_current_path("/restaurants/#{@canada.id}/dishes")
    expect(page).to have_content("Sunrise Cider-cakes")
    expect(page).to have_content("Currently in season: true")
    expect(page).to have_content("Cost: $15")
  end
end

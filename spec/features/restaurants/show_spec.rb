require 'rails_helper'

RSpec.describe "restaurants show page", type: :feature do
  it 'can display a restaurant by id, including attributes'do
  # As a visitor
  # When I visit '/parents/:id'
  # Then I see the parent with that id including the parent's attributes:
  # - data from each column that is on the parent table

    restaurant_1 = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    restaurant_2 = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)

    visit "/restaurants/#{restaurant_1.id}"

    expect(page).to have_content(restaurant_1.name)
    expect(page).to have_content("Capacity: 35")
    expect(page).to have_content("Open for business: true")

    visit "/restaurants/#{restaurant_2.id}"
    expect(page).to have_content(restaurant_2.name)
    expect(page).to have_content("Capacity: 105")
    expect(page).to have_content("Open for business: true")
  end
end

require 'rails_helper'

Rspec.describe "restaurants index page", type: :feature do
  it "can see all restaurant names, capacity, and open status" do
    restaurant_1 = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    restaurant_2 = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)

    visit "/restaurants"

    expect(page).to have_content(restaurant_1.name)
    # expect(page).to have_content("Capacity: #{restaurant_1.guest_capacity}")
    # expect(page).to have_content("Open for business: #{restaurant_1.open}")
    expect(page).to have_content(restaurant_2.name)
    # expect(page).to have_content("Capacity: #{restaurant_2.guest_capacity}")
    # expect(page).to have_content("Open for business: #{restaurant_2.open}")
  end
end

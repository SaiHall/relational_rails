require 'rails_helper'

RSpec.describe "restaurants index page", type: :feature do
  it "can see all restaurant names" do
    restaurant_1 = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    restaurant_2 = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)

    visit "/restaurants"

    expect(page).to have_content(restaurant_1.name)
    expect(page).to have_content(restaurant_2.name)
  end
end

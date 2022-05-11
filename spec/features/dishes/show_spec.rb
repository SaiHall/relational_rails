require 'rails_helper'

RSpec.describe "Dishes show page", type: :feature do
  # As a visitor
  # When I visit '/child_table_name/:id'
  # Then I see the child with that id including the child's attributes:
  it 'can show details on a single dish from database' do
    dish_1 = Dish.create!(name: "Fried Pickles", in_season: true, cost: 8)
    dish_2 = Dish.create!(name: "Banana Pudding", in_season: false, cost: 5)

    visit "/dishes/#{dish_1.id}"

    expect(page).to have_content("Fried Pickles")
    expect(page).to have_content("Currently in season: true")
    expect(page).to have_content("Cost: $8")
    expect(page).to have_content("Added on: #{dish_1.created_at}")
    expect(page).to have_content("Last updated at: #{dish_1.updated_at}")

    visit "/dishes/#{dish_2.id}"

    expect(page).to have_content("Banana Pudding")
    expect(page).to have_content("Currently in season: false")
    expect(page).to have_content("Cost: $5")
    expect(page).to have_content("Added on: #{dish_2.created_at}")
    expect(page).to have_content("Last updated at: #{dish_2.updated_at}")
  end
end

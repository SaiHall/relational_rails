require 'rails_helper'

RSpec.describe 'Specific restaurant dishes index', type: :feature do
  before(:each) do
    @fry_pickle = Dish.create!(name: "Fried Pickles", in_season: true, cost: 8)
    @banana_pud = Dish.create!(name: "Banana Pudding", in_season: false, cost: 5)

    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
  end

  it 'can display all dishes a particular restaurant has, and that dishes attributes' do
    visit "/restaurants/#{@flapjack.id}/dishes"

    expect(page).to have_content("Fried Pickles")
    expect(page).to have_content("Currently in season: true")
    expect(page).to have_content("Cost: $8")
    expect(page).to have_content("Added on: #{@fry_pickle.created_at}")
    expect(page).to have_content("Last updated at: #{@fry_pickle.updated_at}")
  end
end

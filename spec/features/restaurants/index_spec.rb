require 'rails_helper'

RSpec.describe "restaurants index page", type: :feature do
  before(:each) do
    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)

    visit "/restaurants"
  end

  it "can see all restaurant names" do

    expect(page).to have_content(@billy.name)
    expect(page).to have_content(@flapjack.name)
  end
# As a visitor
# When I visit the parent index,
# I see that records are ordered by most recently created first
# And next to each of the records I see when it was created

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
end

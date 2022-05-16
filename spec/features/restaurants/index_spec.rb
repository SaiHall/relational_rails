require 'rails_helper'

RSpec.describe "restaurants index page", type: :feature do
  before(:each) do
    @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
    @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
    @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
    @banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
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

  describe 'Functioning links' do
    it 'has a working link to the dishes index' do
      visit "/restaurants"
      expect(page).to have_content("All Dishes")
      click_on('All Dishes')
      expect(page).to have_current_path("/dishes")
      expect(page).to have_content("Fried Pickles")
    end

    it 'has a working link to the restaurants index' do
      visit "/restaurants"

      expect(page).to have_content("All Restaurants")
      click_on('All Restaurants')

      expect(page).to have_current_path("/restaurants")
      expect(page).to have_content("Flapjack's")
    end
  end

  describe 'New restaurant creation' do
# As a visitor
# When I visit the Parent Index page
# Then I see a link to create a new Parent record, "New Parent"
# When I click this link
# Then I am taken to '/parents/new' where I  see a form for a new parent record
# When I fill out the form with a new parent's attributes:
# And I click the button "Create Parent" to submit the form
# Then a `POST` request is sent to the '/parents' route,
# a new parent record is created,
# and I am redirected to the Parent Index page where I see the new Parent displayed.
    it 'has a link that leads to a page to create a new restaurant' do
      visit "/restaurants"

      click_link("New Restaurant")

      expect(page).to have_current_path("/restaurants/new")
    end
  end
end

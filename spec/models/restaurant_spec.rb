require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :guest_capacity}
    it { should allow_value(true).for(:open)}
    it { should allow_value(false).for(:open)}
  end

  describe 'relationships' do
    it {should have_many :dishes}
  end

  describe 'class methods' do
    it 'puts restaurants in order, newest first' do
      @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
      @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
      expect(Restaurant.all.newest_first[0].name).to eq("Flapjack's")
      expect(Restaurant.all.newest_first[1].name).to eq("Billy's BBQ Bodega")
    end
  end

  describe 'instance methods' do
    before(:each) do
      @billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
      @flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
      @fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
      @banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
    end

    it 'can count how many dishes are associated with a restaurant' do
      expect(@flapjack.dish_count).to eq(1)
      expect(@billy.dish_count).to eq(1)

      chicken_wing = @billy.dishes.create!(name: "Chicken Wings", in_season: true, cost: 12)

      expect(@flapjack.dish_count).to eq(1)
      expect(@billy.dish_count).to eq(2)
    end

    it 'can sort children based off parameters, and give default if none provided' do
      billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
      fry_pickle = billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
      banana_pud = billy.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
      waffle = billy.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)

      expect(billy.filtered(nil, 10)).to eq([waffle])
      expect(billy.filtered("alphabetically")).to eq([banana_pud, waffle, fry_pickle])
      expect(billy.filtered).to eq([fry_pickle, banana_pud, waffle])
    end
  end
end

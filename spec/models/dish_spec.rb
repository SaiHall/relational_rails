require 'rails_helper'

RSpec.describe Dish, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :cost}
    it { should allow_value(true).for(:in_season)}
    it { should allow_value(false).for(:in_season)}
  end

  describe 'relationships' do
    it {should belong_to :restaurant}
  end

  describe 'class methods' do
    it 'can sort out out of season dishes' do
      billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
      flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
      fry_pickle = billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
      seasonal = Dish.all

      expect(seasonal.by_in_season).to eq([fry_pickle])

      waffle = flapjack.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)
      seasonal = Dish.all

      expect(seasonal).to eq([fry_pickle, waffle])
      expect(seasonal.by_in_season).to eq([fry_pickle])
    end

    it 'can alphabetize dishes' do
      billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
      flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)
      fry_pickle = billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
      banana_pud = flapjack.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
      waffle = flapjack.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)

      menu = Dish.all

      expect(menu.filtered_by("alphabetically")).to eq([banana_pud, waffle, fry_pickle])
    end

    it 'can return dishes with a cost over x' do
      billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
      fry_pickle = billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
      banana_pud = billy.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
      waffle = billy.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)

      menu = Dish.all

      expect(menu.filtered_by(nil, 10)).to eq([waffle])
    end

    it 'can return dishes with a cost over x, and sort alphabetically' do
      billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
      fry_pickle = billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 11)
      banana_pud = billy.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
      waffle = billy.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)

      menu = Dish.all

      expect(menu.filtered_by("alphabetically", 10)).to eq([ waffle, fry_pickle])
    end

    it 'will return no sorting without an argument' do
      billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
      fry_pickle = billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
      banana_pud = billy.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
      waffle = billy.dishes.create!(name: "Belgian Bonanza", in_season: false, cost: 13)

      menu = Dish.all

      expect(menu.filtered_by).to eq([fry_pickle, banana_pud, waffle])
    end
  end
end

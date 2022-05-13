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
end

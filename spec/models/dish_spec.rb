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
end

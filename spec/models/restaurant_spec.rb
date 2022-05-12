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

end

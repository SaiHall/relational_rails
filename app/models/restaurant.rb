class Restaurant < ApplicationRecord
  has_many :dishes

  validates_presence_of :name, :guest_capacity
  validates :open, inclusion: [ true, false ]

  def self.newest_first
    order(created_at: :desc)
  end

  def dish_count #Ruby? ActiveRecord? Refactor this.
    dishes.count
  # dishes.count("restaurant_id = #{self.id}") #Absolutely active record
  # self.dishes.count
  end
end

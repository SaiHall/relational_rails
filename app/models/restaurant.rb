class Restaurant < ApplicationRecord
  has_many :dishes

  validates_presence_of :name, :guest_capacity
  validates :open, inclusion: [ true, false ]
end

class Dish < ApplicationRecord
  belongs_to :restaurant

  validates_presence_of :name, :cost
  validates :in_season, inclusion: [ true, false ]
end

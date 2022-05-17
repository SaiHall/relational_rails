class Dish < ApplicationRecord
  belongs_to :restaurant

  validates_presence_of :name, :cost
  validates :in_season, inclusion: [ true, false ]

  def self.by_in_season
    all.where(in_season: true)
  end
end

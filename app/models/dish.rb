class Dish < ApplicationRecord
  belongs_to :restaurant

  validates_presence_of :name, :cost
  validates :in_season, inclusion: [ true, false ]

  def self.by_in_season
    all.where(in_season: true)
  end

  # def self.alphabetize
  #   order(:name)
  # end
  #
  #
  # def self.cost_over_threshold(quantity)
  #   Dish.where("cost > #{quantity}")
  # end

  def self.filtered_by(sort = nil, value = nil)
    if sort == "alphabetically"
      order(:name)
    elsif !value.nil?
      Dish.where("cost > #{value}")
    else
      Dish.all
    end
  end
end

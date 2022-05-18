class Dish < ApplicationRecord
  belongs_to :restaurant

  validates_presence_of :name, :cost
  validates :in_season, inclusion: [ true, false ]

  def self.by_in_season
    all.where(in_season: true)
  end

  def self.filtered_by(sort = nil, value = nil)
    if sort == "alphabetically" && !value.nil?
      Dish.where("cost > #{value.to_i}").order(:name)
    elsif sort == "alphabetically"
      order(:name)
    elsif !value.nil?
      Dish.where("cost > #{value.to_i}")
    else
      Dish.all
    end
  end
end

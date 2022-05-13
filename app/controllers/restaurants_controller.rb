class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all.newest_first
  end

  def show #Can add these to application controller if reused?
    @restaurant = Restaurant.find(params[:id])
  end
end

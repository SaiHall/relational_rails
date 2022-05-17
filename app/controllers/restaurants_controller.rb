class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all.newest_first
  end

  def show #Can add these to application controller if reused?
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    Restaurant.create(rest_params)

    redirect_to "/restaurants"
  end

  private
    def rest_params
      params.permit(:name, :open, :guest_capacity)
    end
end

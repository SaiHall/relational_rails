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

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    restaurant = Restaurant.find(params[:id])
    restaurant.update_attributes(rest_params)
    # restaurant.save

    redirect_to "/restaurants/#{restaurant.id}"
  end

  private
    def rest_params
      params.permit(:name, :open, :guest_capacity)
    end
end

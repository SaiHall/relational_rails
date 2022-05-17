class RestaurantDishesController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dishes = @restaurant.dishes
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    Dish.create(rest_dish_params)
    redirect_to "/restaurants/#{params[:restaurant_id]}/dishes"
  end

  private
    def rest_dish_params
      params.permit(:name, :in_season, :cost, :restaurant_id)
    end
end

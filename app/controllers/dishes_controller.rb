class DishesController < ApplicationController
  def index
    @dishes = Dish.all.by_in_season
  end

  def show
    @dish = Dish.find(params[:id])
  end

  def edit
    # binding.pry
    @dish = Dish.find(params[:id])
  end

  def update
    dish = Dish.find(params[:id])
    dish.update_attributes(dish_params)

    redirect_to "/dishes/#{dish.id}"
  end

  def delete
    dish = Dish.find(params[:id])
    dish.destroy
    redirect_to "/dishes"
  end

  private
    def dish_params
      params.permit(:name, :in_season, :cost)
    end
end

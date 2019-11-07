class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(strong_params)
    @cocktail.user = current_user
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  private

  def strong_params
    params.require(:cocktail).permit(:name, :description, :photo)
  end

end

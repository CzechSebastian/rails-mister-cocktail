class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
    if params[:search]
      @cocktails = Cocktail.search(params[:search]).order("created_at DESC")
    else
      @cocktails = Cocktail.all.order('created_at DESC')
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    # photo_path = params[:cocktail][:photo]
    # photo_path = photo_path.tempfile
    if @cocktail.save
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @cocktail.update(cocktail_params)

    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name , :photo)
  end
end

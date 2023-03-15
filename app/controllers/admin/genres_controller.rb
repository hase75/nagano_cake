class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genres_params)
    @genre.save
    redirect_to admin_genres_path
  end




  private

  def genres_params
    params.require(:genres).permit(:name)
  end

end

class FavoritesController < ApplicationController
  def create
    @note = Note.find(params[:favorite][:note_id])
    current_user.favorite!(@note)
    redirect_to @note
  end

  def destroy
    @note = Favorite.find(params[:id]).note
    current_user.unfavorite!(@note)
    redirect_to @note
  end
end
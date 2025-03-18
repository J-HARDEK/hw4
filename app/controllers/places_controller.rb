class PlacesController < ApplicationController
  def index
    if session["user_id"]
      @places = Place.where(user_id: session["user_id"])  # Only show places for the logged-in user
    else
      flash["notice"] = "You must be logged in to see places."
      redirect_to "/login"
    end
  end

  def show
    @place = Place.find_by(id: params["id"], user_id: session["user_id"]) # Ensure user owns the place

    if @place
      @entries = Entry.where(place_id: @place.id)  # Load associated entries
    else
      flash["notice"] = "You don't have access to this place."
      redirect_to "/places"
    end
  end
end

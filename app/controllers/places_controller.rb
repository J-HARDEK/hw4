class PlacesController < ApplicationController
  def index
    if session["user_id"]
      @places = Place.joins(:entries).where(entries: { user_id: session["user_id"] }).distinct
    else
      flash["notice"] = "You must be logged in to see places."
      redirect_to "/login"
    end
  end

  def show
    @place = Place.find_by(id: params["id"])
    if @place && Entry.exists?(place_id: @place.id, user_id: session["user_id"])
      @entries = Entry.where(place_id: @place.id)
    else
      flash["notice"] = "You don't have access to this place."
      redirect_to "/places"
    end
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    if @place.save
      Entry.create(place_id: @place.id, user_id: session["user_id"], title: "", description: "", occurred_on: Date.today)
      flash["notice"] = "Place added!"
      redirect_to "/places"
    else
      flash["notice"] = "Error adding place."
      render "new"
    end
  end
end
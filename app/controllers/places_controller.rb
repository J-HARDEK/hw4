class PlacesController < ApplicationController
  def index
    if session["user_id"]
      puts "DEBUG: session user_id = #{session["user_id"]}"  # Check if user_id is set
      
      @places = Place.where(user_id: session["user_id"])
      puts "DEBUG: Found places = #{@places.inspect}"  # Print places found

      if @places.empty?
        flash["notice"] = "No places found. Try adding one."
      end
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

  def new
    @place = Place.new
  end

  def create
    if session["user_id"]
      @place = Place.new({
        "name" => params["name"],
        "user_id" => session["user_id"]
      })

      if @place.save
        flash["notice"] = "Place added successfully!"
        redirect_to "/places"
      else
        flash["notice"] = @place.errors.full_messages.join(", ")
        redirect_to "/places/new"
      end
    else
      flash["notice"] = "You must be logged in to add a place."
      redirect_to "/login"
    end
  end
end

class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    if session["user_id"]
      place = Place.find_by(id: params["place_id"])
      if place.nil? || !Entry.where(place_id: place.id, user_id: session["user_id"]).exists?
        flash["notice"] = "Invalid place selection. Try again, Traveler"
        redirect_to "/places"
        return
      end

      @entry = Entry.new({
        "title" => params["title"],
        "description" => params["description"],
        "occurred_on" => params["occurred_on"],
        "place_id" => params["place_id"],
        "user_id" => session["user_id"]
      })

      if @entry.save
        flash["notice"] = "Thanks Traveler, Entry Added!"
        redirect_to "/places/#{params["place_id"]}"
      else
        flash["notice"] = @entry.errors.full_messages.join(", ")
        redirect_to "/entries/new?place_id=#{params["place_id"]}"
      end
    else
      flash["notice"] = "You must be logged in to see your places."
      redirect_to "/login"
    end
  end
end
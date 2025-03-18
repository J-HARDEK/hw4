class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    if session["user_id"]
      @entry = Entry.new({
        "title" => params["title"],
        "description" => params["description"],
        "occurred_on" => params["occurred_on"],
        "place_id" => params["place_id"],
        "user_id" => session["user_id"]
      })

      if @entry.save
        flash["notice"] = "Entry added!"
        redirect_to "/places/#{params["place_id"]}"
      else
        flash["notice"] = @entry.errors.full_messages.join(", ")
        redirect_to "/entries/new?place_id=#{params["place_id"]}"
      end
    else
      flash["notice"] = "You must be logged in."
      redirect_to "/login"
    end
  end
end
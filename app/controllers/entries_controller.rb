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
        "user_id" => session["user_id"]
      })

      if @entry.save
        flash["notice"] = "Entry added!"
        redirect_to "/places"
      else
        flash["notice"] = "Error saving entry."
        redirect_to "/entries/new"
      end
    else
      flash["notice"] = "You must be logged in."
      redirect_to "/login"
    end
  end
end

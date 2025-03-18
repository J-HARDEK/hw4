class PlacesController < ApplicationController
  def index
    @user = User.find_by(id: session["user_id"])
    if @user.nil?
      flash["notice"] = "You must be logged in to view places."
      redirect_to "/login"
    else
      @places = Place.where(name: @user.username)
    end
  end

  def new
  end

  def create
    @user = User.find_by(id: session["user_id"])
    if @user.nil?
      flash["notice"] = "Login first."
      redirect_to "/login"
      return
    end
    
    @place = Place.new
    @place.name = params["name"]
    
    if @place.save
      flash["notice"] = "Place created successfully!"
    else
      flash["notice"] = "Error saving place"
    end
    
    redirect_to "/places"
  end

  before_action :allow_cors
  def allow_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response.headers['Access-Control-Max-Age'] = '1728000'
  end
end
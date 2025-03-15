class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome Traveler!"
        redirect_to "/places"
      else
        flash["notice"] = "Incorrect Login Credentials. Please Try Again."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Incorrect Login Credentials. Please Try Again."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "See You Next Time!"
    redirect_to "/login"
  end
end

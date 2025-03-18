class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })

    if @user && BCrypt::Password.new(@user["password"]).is_password?(params["password"])
      session["user_id"] = @user["id"]
      session["username"] = @user["username"]
      flash["notice"] = "Welcome back, #{@user.username}!"
      redirect_to "/places"
    else
      flash["notice"] = "The email or password you provided was invalid. Try again"
      redirect_to "/login"
    end  
  end

  def destroy
    session["user_id"] = nil
    session["username"] = nil
    flash["notice"] = "Logged out - See you next time, Traveler!"
    redirect_to "/login"
  end
end

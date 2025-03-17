class UsersController < ApplicationController
  def new
  end

  def create
    existing_user = User.find_by({ "email" => params["email"] })
    
    if existing_user
      flash["notice"] = "Email already exists. Please login to your existing account."
      redirect_to "/signup"
    else
      hashed_password = BCrypt::Password.create(params["password"])
      @user = User.new({ "email" => params["email"], "password" => hashed_password })
      
      if @user.save
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome!"
        redirect_to "/places"
      else
        flash["notice"] = "Signup failed."
        redirect_to "/signup"
      end
    end
  end
end

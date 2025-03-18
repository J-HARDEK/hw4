class UsersController < ApplicationController
  def new
  end

  def create
    existing_user = User.find_by(email: params["email"])

    if existing_user
      flash["notice"] = "Email already exists. Please log in."
      redirect_to "/signup"
    else
      hashed_password = BCrypt::Password.create(params["password"])
      @user = User.new({
        "username" => params["username"],
        "email" => params["email"],
        "password" => hashed_password
      })

      if @user.save
        session["user_id"] = @user["id"]
        session["username"] = @user["username"]
        flash["notice"] = "Welcome, #{@user.username}!"
        redirect_to "/places"
      else
        flash["notice"] = "Signup failed. Please try again."
        redirect_to "/users/new"
      end
    end
  end
end

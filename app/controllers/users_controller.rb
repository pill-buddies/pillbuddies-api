class UsersController < ApplicationController
  def show
    unless session[:user_uid] = params[:uid]
      render json: { message: "Not authenticated, please log in" }, status: 401 and return
    end

    user = User.where(["uid = ?", params[:uid]]).select("name, email, uid, provider, created_at, updated_at").first
    render json: { user: user }, status: 200 and return
  end

  def create
    user = User.find_by(email: params.email)
    if user
      render json: { message: "User already exists" }, status: 400 and return
    end

    user = User.create(params) do |new_user|
      new_user.provider = nil
    end
    
    redirect_to sessions_controller_create_url
  end
end

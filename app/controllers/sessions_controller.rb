require 'securerandom'

class SessionsController < ApplicationController
  def show
    render json: { user_uid: session[:user_uid] }, status: 200 and return 
  end

  def create
    if params[:provider]
      user = User.find_or_create_by(email: params.email) do |new_user|
        new_user.email = params.email
        new_user.name = params.name
        new_user.uid = SecureRandom.uuid
        new_user.provider = params[:provider]

        new_user.password = new_user.password_confirmation = SecureRandom.base64(12)
      end
    else
      user = User.find_by(email: params.email)

      unless user
        render json: { message: "Email not found" }, status: 400 and return
      end

      if user.provider != nil
        render json: { message: "User is linked to single sign-on", provider: user.provider }, status: 422 and return
      end

      unless user.authenticate(params.password)
        render json: { message: "Incorrect password" }, status: 400 and return
      end
    end
    session[:user_uid] = user.uid
    render json: { message: "Signed in" }, status: 200 and return
  end

  def destroy
    session[:user_uid] = nil
    render json: { message: "Signed out" }, status: 200 and return
  end
end

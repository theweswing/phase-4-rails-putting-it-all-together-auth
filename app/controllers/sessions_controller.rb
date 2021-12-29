class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create

  def create
    found_user = User.find_by(username: params[:username])
    if found_user&.authenticate(params[:password])
      session[:user_id] = found_user.id
      render json: found_user, status: :created
    else
      render json: {
               errors: ['Invalid username or password'],
             },
             status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    head :no_content
  end
end

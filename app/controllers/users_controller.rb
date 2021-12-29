class UsersController < ApplicationController
  # rescue_from ActiveRecord::RecordInvalid, with: :invalid_input
  skip_before_action :authorize, only: :create

  def create
    new_user = User.create!(strong_params)
    session[:user_id] = new_user.id
    render json: new_user, status: :created
  end

  def show
    render json: @current_user
  end

  private

  def strong_params
    params.permit(
      :username,
      :password,
      :image_url,
      :bio,
      :password_confirmation,
    )
  end

  # def invalid_input(e)
  #   render json: {
  #            errors: e.record.errors.full_messages,
  #          },
  #          status: :unprocessable_entity
  # end

  # def authorize
  #   unless session.include? :user_id
  #     return render json: { error: 'Not authorized' }, status: unauthorized
  #   end
  # end

  # def show
  #   found_user = User.find_by(id: session[:user_id])
  #   if found_user
  #     render json: found_user, status: :created
  #   else
  #     render json: { error: 'Not authorized' }, status: :unauthorized
  #   end
  # end
end

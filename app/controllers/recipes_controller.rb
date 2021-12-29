class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_input

  def index
    if session[:user_id]
      recipes = Recipe.all
      render json: recipes, include: :user, status: :created
    else
      render json: { error: 'Error' }, status: :unauthorized
    end
  end

  def create
    recipe = @current_user.recipes.create!(recipe_params)
    render json: recipe, status: :created
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

  def invalid_input(e)
    render json: {
             errors: e.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end

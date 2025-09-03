class RecipeRequestsController < ApplicationController
  def show
    @recipe_request = RecipeRequest.find(params[:id])
    puts "RecipeRequest: #{@recipe_request.inspect}"  # Debug statement

    # Force HTML rendering and bypass Turbo
    request.variant = :html
    render template: 'pages/show', formats: :html

  rescue ActiveRecord::RecordNotFound
    redirect_to fridgy_path, alert: "Recipe request not found."
  end
end

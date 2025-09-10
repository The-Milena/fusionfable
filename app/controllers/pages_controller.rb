class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def fridgy
    # For POST requests, this code runs when the form is submitted.
     if request.post?
    # Handle the photo upload - create a new RecipeRequest
    @recipe_request = RecipeRequest.new(user: current_user)

    # Upload the photo to cloudinary
    if params[:photo]
      upload_result = Cloudinary::Uploader.upload(params[:photo].tempfile.path)
      @recipe_request.photo_url = upload_result['secure_url']
    end

    # Debug statements
    puts "User ID: #{current_user&.id}"
    puts "Photo URL: #{@recipe_request.photo_url}"

    # Save RecipeRequest to db and handle success/failure
    if @recipe_request.save
      puts "RecipeRequest saved with ID: #{@recipe_request.id}"  # Debug statement
      AnalyseFridgePhotoJob.perform_later(@recipe_request.id)
      redirect_to recipe_request_path(@recipe_request), notice: "Photo uploaded! We're analyzing your fridge..."
    else
      flash.now[:alert] = "Failed to upload photo. Please try again."
      render :fridgy
    end

  else
    # For GET requests (when the user first visits /fridgy), we create a new RecipeRequest object to use in the form.
    @recipe_request = RecipeRequest.new
  end
  end

  def data_policy
  end

end

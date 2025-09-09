# app/jobs/analyze_fridge_photo_job.rb
class AnalyseFridgePhotoJob < ApplicationJob
  queue_as :default

  def perform(recipe_request_id)
    recipe_request = RecipeRequest.find(recipe_request_id)
    photo_url = recipe_request.photo_url

    puts "Starting analysis for RecipeRequest ID: #{recipe_request_id}"  # Debug

    # Call OpenAI's GPT-4 Vision API
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4-turbo",
        messages: [
          {
            role: "user",
            content: [
              { type: "text", text: "List all the ingredients you can see in this fridge photo. Return only the ingredient names, one per line. If you see any tupperware, return them simply as an ingredient tupperware." },
              { type: "image_url", image_url: { url: photo_url } }
            ]
          }
        ],
        max_tokens: 300
      }
    )

    puts "OpenAI Response: #{response.inspect}"  # Debug

    # Extract and save ingredients
    ingredients = response.dig("choices", 0, "message", "content").split("\n")
    puts "Detected Ingredients: #{ingredients.inspect}"  # Debug

    ingredients.each do |ingredient|
      recipe_request.detected_ingredients.create(name: ingredient.strip) unless ingredient.blank?
    end
    rescue OpenAI::Error => e
    Rails.logger.error "OpenAI API error: #{e.message}"
    # Optionally notify the user or retry the job
  end
end

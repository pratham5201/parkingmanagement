# frozen_string_literal: true

# home controller
class HomeController < ApplicationController
  def home
    if current_user
      show_info({ 'message' => "#{current_user.email}! Welcome to Parking Management API",
                  'user' => current_user_data })
    else
      show_info({ 'message' => 'Welcome to the Parking Management  API',
                  'prompt' => 'Please Login to perform api actions.' })
    end
  end

  private

  # Creating user information in json

  # Only allow a list of trusted parameters through.

  def current_user_data
    if current_user
      data = {
        id: current_user.id,
        name: current_user.name,
        email: current_user.email,
        role: current_user.role,
        floors: gen_floor(current_user)
      }

    end
   { User_Data: data }
  end
end

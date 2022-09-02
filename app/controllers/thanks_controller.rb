# frozen_string_literal: true

# memebers controller
class ThanksController < ApplicationController
  def index
    render json: { message: 'Payment successfull', greeting: 'thanks for using Parking Management API!!'}
  end
end

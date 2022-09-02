# frozen_string_literal: true

# floor controller
class FloorsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_floor, only: %i[show update destroy]

  def index
    render json: gen_floor(current_user)
  end

  def show
    render json: { "Floors": @floor, "slotes": gen_floor_slots(@floor) }
  end

  def create
    if Floor.count <= 9
      # debugger
      # render json: { message: floor_params[floor]}
      f = params[:floor][:floor].to_i
      for i in 1..f
        @floor = Floor.new(floor_params)
        @floor.floor = i
        @floor.user_id = current_user.id
        @floor.save
      end
      # render json: @floor.errors, status: :unprocessable_entity unless @floor.save
      redirect_to root_path
      # render json: @floor, status: :created, location: @floor if @floor.save
      
    else
      render json: { message: 'Maximum limmit reached out, no more floor can be added' }, status: :unprocessable_entity
    end
  end

  def update
    if @floor.update(floor_params)
      render json: @floor
    else
      render json: @floor.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @floor.destroy
    render json: { message: 'Floor deleted successfuly' }
  end

  private

  def set_floor
    @floor = Floor.find(params[:id])
  end

  def floor_params
    params.require(:floor).permit(:floor)
  end
end

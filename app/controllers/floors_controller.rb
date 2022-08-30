# frozen_string_literal: true

# floor controller
class FloorsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_floor, only: %i[show update destroy]

  def index
    @floors = Floor.all
    render json: @floors
  end

  def show
    render json: @floor
  end

  def create
    if Floor.count <= 9
      @floor = Floor.new(floor_params)
      @floor.user_id = current_user.id
      render json: @floor, status: :created, location: @floor if @floor.save
      render json: @floor.errors, status: :unprocessable_entity unless @floor.save
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
  end

  private

  def set_floor
    @floor = Floor.find(params[:id])
  end

  def floor_params
    params.require(:floor).permit(:floor)
  end
end

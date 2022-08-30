# frozen_string_literal: true

# floor controller
class FormsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_form, only: %i[show update destroy]

  # GET /forms
  def index
    @forms = Form.all
    render json: @forms
  end

  # GET /forms/1
  def show
    render json: @form
  end

  def create
    @form = Form.new(form_params)
    if @form.floor.floors.length < 9
      @form.floor_id = session[:floor_id]
      @form.intime = DateTime.now
      render json: @form, status: :created if @form.save
      render json: @form.errors, status: :unprocessable_entity unless @form.save
    else
      render json: { message: 'slot limit exceeded' }
    end
  end

  # PATCH/PUT /forms/1
  def update
    if @form.update(form_params)
      @form.outtime = DateTime.now
      @form.time = (@form.outtime.to_time.to_i - @form.intime.to_time.to_i).to_f / 60
      @form.price = @form.time / 60 * 100 # price for 1 hour is 100
      @form.save
      render json: @form
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  # DELETE /forms/1
  def destroy
    @form.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = Form.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def form_params
    params.require(:form).permit(:clientname, :carnumber, :carcolor, :price, :slot, :status, :floor_id, :user_id)
  end
end

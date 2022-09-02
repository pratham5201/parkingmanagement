# frozen_string_literal: true

# floor controller
class FormsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_form, only: %i[show update destroy]

  # GET /forms
  def index
    @forms = Form.all
    render json: { "message": 'welcome to the Floor', "slotes": @forms }
  end

  # GET /forms/1
  def show
    if @form.status == 'Booked'
      render json: { "message": 'Slot already booked' }
    else
      render json: { "message": 'You can book this slot', "slot": @form }
    end
  end

  def create
    if current_user.role == 'admin'
      if @form.floor.forms.length < 9
        f = params[:form][:slotn].to_i
        for i in 1..f
          @form = Form.new(form_params)
          @form.intime = DateTime.now
          @form.slot = i
          @form.user_id = current_user.id
          @form.save
        end
        redirect_to root_path
        # @form.intime = DateTime.now
        # render json: @form, status: :created if @form.save
        # render json: @form.errors, status: :unprocessable_entity unless @form.save
      else
        render json: { message: 'slot limit exceeded' }
      end
    elsif @form.floor.forms.length < 9
      @form.intime = DateTime.now
      render json: @form, status: :created if @form.save
      render json: @form.errors, status: :unprocessable_entity unless @form.save
    else
      render json: { message: 'slot limit exceeded' }
    end
  end
  #   f = params[:floor][:floor].to_i
  #     for i in 1..f
  #       @floor = Floor.new(floor_params)
  #       @floor.floor = i
  #       @floor.user_id = current_user.id
  #       @floor.save
  #     end
  #     redirect_to root_path
  # end

  # PATCH/PUT /forms/1
  def update
    if @form.update(form_params)
      @form.outtime = Time.now
      @form.time = (@form.outtime.to_time.to_i - @form.intime.to_time.to_i).to_f / 60
      @form.price = (@form.time / 60) * 100 # price for 1 hour is 100
      slot_payment(@form.price) if @form.status == 'unbooked'
      @form.save
      render json: @form, status: 200
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  # DELETE /forms/1
  def destroy
    @form.destroy
    render json: { message: 'Slot deleted successfuly' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = Form.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def form_params
    params.require(:form).permit(:slotn, :clientname, :carnumber, :carcolor, :slot, :status, :floor_id, :user_id)
  end
end

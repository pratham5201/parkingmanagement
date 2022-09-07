# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActionDispatch::Request::Session::DisabledSessionError, with: :render_session_disabled
  rescue_from CanCan::AccessDenied, with: :render_denied_access

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_session_disabled
    render json: { error: exception.message }, status: 500
  end

  def render_denied_access(_exception)
    render json: { error: 'User Access Denied!' }, status: 500
  end

  def check_user_params
    params[:user].present?
  end

  def show_info(response)
    render json: response, status: 200
  end

  def routing_error
    # render_exception(404, "Routing Error", exception)
    render json: {
      message: 'please check url no route matches'
    }, status: :not_found
  end

  def gen_floor(user)
    data = []
    user.floors.each do |floor|
      data << {
        floor_id: floor.id,
        floor_number: floor.floor,
        floor_slots_length: floor.forms.count,
        floor_slots: gen_floor_slots(floor),
        floor_url: floor_url(floor)
        # Floor_link: link_to 'Floor', {:controller => "floor", :action => "show", :id => floor.id }
      }
    end
    { Floors: data }
  end

  def gen_floor_slots(floor)
    data = []
    floor.forms.each do |slot|
      data << {
        slot_id: slot.id, client_name: slot.clientname,
        car_number: slot.carnumber,
        car_color: slot.carcolor,
        status: slot.status,
        sloot_url: form_url(slot),
        sloot_price: slot.price
      }
    end
    { slots: data }
  end

  def slot_payment(price)
    require('stripe')

    Stripe.api_key = 'sk_test_51LdFA9SANCZEKwhAsHtz1068unX0UQBWujOauuu7MzvoySKcDkCknV2CDB26VgUeEgGz3xoo0PVZRRZ7jveK2Mwv00AWm6JrhC'

    price = Stripe::Price.create({
                                   unit_amount: price * 100,
                                   currency: 'inr',
                                   product: 'prod_MM04XZUGZsX8Ow'
                                 })

    order = Stripe::PaymentLink.create(
      line_items: [{ price: price.id, quantity: 1 }],
      after_completion: { type: 'redirect', redirect: { url: 'http://localhost:3000/thanks' } }
    )
    system('xdg-open', order.url)
  end

  # def routing_error(_error = 'Routing error', _status = :not_found, _exception = nil)
  #   # render_exception(404, "Routing Error", exception)
  #   render json: {
  #     message: 'Please Check Your Routes!!'
  #   }, status: :not_found
  # end
  
end

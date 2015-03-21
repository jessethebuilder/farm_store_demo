class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #
  # def set_farm_store_order
  #   if user_signed_in?
  #     @farm_store_order = current_user.farm_store_orders.open || current_user.build_farm_store_open_orders
  #   else
  #     @farm_store_order = FarmStoreOrder.where(:id => session[:farm_store_order_id]).first || FarmStoreOrder.create
  #     session[:farm_store_order_id] = @farm_store_order.id
  #   end
  # end


  def current_order
    if user_signed_in?
      farm_store_order = current_user.farm_store_orders.open.first || current_user.farm_store_orders.create
    else
      farm_store_order = FarmStoreOrder.where(:id => session[:farm_store_order_id]).first || FarmStoreOrder.create
      session[:farm_store_order_id] = farm_store_order.id
    end
    farm_store_order
  end

end

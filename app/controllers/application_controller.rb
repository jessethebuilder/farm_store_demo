class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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

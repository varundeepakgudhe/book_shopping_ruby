module ApplicationHelper
  def current_order
    p session[:order_id]
    if Order.find_by(session[:order_id].to_s).nil?
      Order.new
    else
      Order.find_by(session[:order_id].to_s)
    end
  end
end

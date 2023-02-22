module ApplicationHelper
  def current_order
    if Order.find_by(session[:order_id]).nil?
      Order.new
    else
      Order.find_by(session[:order_id])
    end
  end
end

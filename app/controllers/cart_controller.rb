 class CartController < ApplicationController
   include ApplicationHelper

  def show
    @order_items = current_order.order_items
  end
   def destroy
     @order_items.destroy
     @order_items = current_order.order_items
   end
end

class OrderItemsController < ApplicationController
  before_action :set_order
  before_action :authenticate_user!
  def create

    @order_item = @order.order_items.new(order_params)
    @order.save
    session[:order_id] = @order.id
    redirect_to books_path
  end

  def update
    @order_item = @order.order_items.find(params[:id])
    @book = Book.find(@order_item.book_id)

    if params[:order_item][:quantity].to_i == 0
      @order_item.destroy
      redirect_to cart_path, notice: "item removed successfully"
    else
      if @book.stock >= params[:order_item][:quantity].to_i
        @order_item.quantity = params[:order_item][:quantity].to_i
        @order_item.total = @order_item.unit_price * params[:order_item][:quantity].to_i
        @order_item.save
        redirect_to cart_path, notice: "item updated successfully"
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end


    @order_items = current_order.order_items
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = current_order.order_items
  end

  def delete
    @order.destroy
  end

  private
  def order_params
    params.require(:order_item).permit(:book_id, :quantity)
  end

  def set_order
    @order = current_order
  end
end

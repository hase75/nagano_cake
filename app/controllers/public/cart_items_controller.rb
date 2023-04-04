class Public::CartItemsController < ApplicationController
  def index
    @cart_items = Cart_item.all
  end
  
  def create
    cart_item = Cart_item.new(cart_item_params)
    cart_item.customer_id = current_customer.id
    cart_item.save
    redirect_to itms_path
  end
  
  private

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end
  
end

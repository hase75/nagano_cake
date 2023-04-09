class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end
  
  def confirm
    @order = Order.new(order_params)
    
    if params[:order][:select_address] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
  
    elsif params[:order][:select_address] == "1"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    
    elsif params[:order][:select_address] = "2"
    @order.postal_code = params[:order][:postal_code]
    @order.address = params[:order][:ddress]
    @order.name = params[:order][:name]
    else
      render 'new'
    end
    
    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    
    current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
      @ordered_item = OrderedItem.new #初期化宣言
      @ordered_item.item_id = cart_item.item_id #商品idを注文商品idに代入
      @ordered_item.amount = cart_item.amount #商品の個数を注文商品の個数に代入
      @ordered_item.tprice = (cart_item.item.price*1.1).floor #消費税込みに計算して代入
      @ordered_item.order_id =  @order.id #注文商品に注文idを紐付け
      @ordered_item.save #注文商品を保存
    end
    
    current_member.cart_items.destroy_all #カートの中身を削除
    redirect_to orders_complete_path
  end


  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show

  end
  
  private
  
  def order_params
  params.require(:order).permit(:shipping_cost, :payment_method, :name, :address, :postal_code ,:customer_id,:total_payment,:status)
  end
  
end

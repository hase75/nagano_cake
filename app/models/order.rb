class Order < ApplicationRecord
  
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum select_address: { my_address: 0, registered_address: 1 , new_address: 2}
  
end

class Order < ActiveRecord::Base	
  belongs_to :user
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true 

  has_many :placements
  has_many :products, through: :placements

  before_validation :set_total!

  validates_with EnoughProductsValidator

  def set_total!
    self.total = 0
    placements.each do |placement|
      self.total += placement.product.price * placement.quantity
    end
  end

  # really important method, and shows how rails is; letting you build your own data structures.
  # here this method is attempting to take the order as an array of array's, with the first being the
  # id of the product, and the second being the quantity
  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities) 
   	product_ids_and_quantities.each do |product_id_and_quantity| # [[1,5],[2,3]]
   	  id, quantity = product_id_and_quantity # [1,5]
   	  self.placements.build(product_id: id, quantity: quantity) # telling the db the product_id is the first value of the current array
   	end
  end
end

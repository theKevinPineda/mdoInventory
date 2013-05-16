class Product < ActiveRecord::Base
  attr_accessible :name, :owner, :quantity
  validates :name, :owner, :quantity, :presence => true
  validates :quantity, :numericality => {greater_than: 0}
  def self.checkElseUpdate product
    @product =  Product.find_by_name(product.name)
    if @product.nil?
      return product.save
    else
      return @product.update_attributes(:quantity => @product.quantity+product.quantity)
    end
  end

end

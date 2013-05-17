class Product < ActiveRecord::Base
  attr_accessible :name, :owner, :quantity, :photo
  has_attached_file :photo,
                  :default_url => "/assets/missing.gif",
                  :url  => "/assets/products/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
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

  def self.getAll
    @product = Product.all
  end
  
  private 
  def paginateThis product
  end
end

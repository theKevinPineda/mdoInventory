class Product < ActiveRecord::Base
  attr_accessible :name, :owner, :quantity, :photo, :user_id
  has_attached_file :photo,
    :default_url => "/assets/missing.gif",
    :url  => "/assets/products/:id/:style/:hash.:extension",
    :path => ":rails_root/public/assets/products/:id/:style/:hash.:extension",
    :hash_secret => MdoInventory::Application.config.secret_token
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  validates :name, :user_id, :quantity, :presence => true
  validates :quantity, :numericality => {greater_than: 0}
  belongs_to :user
  def self.checkElseUpdate product
    @product =  Product.find_by_name(product.name)
    if @product.nil?
      return product.save
    else
      return @product.update_attributes(:quantity => @product.quantity+product.quantity)
    end
  end
end

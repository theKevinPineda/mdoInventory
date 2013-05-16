class Product < ActiveRecord::Base
  attr_accessible :name, :owner, :quantity
end

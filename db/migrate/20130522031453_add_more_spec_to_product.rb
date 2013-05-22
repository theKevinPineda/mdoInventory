class AddMoreSpecToProduct < ActiveRecord::Migration
  def change
    change_column :products, :owner, :integer
  end
end

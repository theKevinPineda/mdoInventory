class ChangeReferenceProduct < ActiveRecord::Migration
  def change
    change_column :products, :user_id, :reference
  end
end

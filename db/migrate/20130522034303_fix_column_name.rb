class FixColumnName < ActiveRecord::Migration
  def change
   rename_column :products,  :owner, :user_id 
  end
end

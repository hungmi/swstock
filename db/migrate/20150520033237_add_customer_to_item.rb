class AddCustomerToItem < ActiveRecord::Migration
  def change
    add_column :items, :customer, :string
  end
end

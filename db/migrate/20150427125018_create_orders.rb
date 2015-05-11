class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :picnum
      t.string :amount

      t.timestamps null: false
    end
  end
end

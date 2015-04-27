class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :location
      t.string :item_type
      t.string :picnum
      t.string :amount

      t.timestamps null: false
    end
  end
end

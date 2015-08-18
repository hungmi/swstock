class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|      
      t.text :sourcing_type, :order_date, :customer, :material_spec, :order_amount, :item_type, :picnum, :stage_amount, :factory, :arrival_date, :estimated_date, :note, :finish_date, :finished, :broken

      t.timestamps null: false
    end
  end
end

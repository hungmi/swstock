class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|      
      t.string :factory_name
      t.date :arrival_date, :estimated_date, :finished_date
      t.integer :arrival_amount, :finished_amount, :broken_amount
      t.text :note
      t.references :procedure, index: true, foreign_key: true
      #t.references :factory, index: true, foreign_key: true
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end

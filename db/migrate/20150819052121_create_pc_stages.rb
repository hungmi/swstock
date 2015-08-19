class CreatePcStages < ActiveRecord::Migration
  def change
    create_table :pc_stages do |t|      
      t.string :factory_name, :arrival_date, :estimated_date, :finish_date
      t.integer :amount, :finished, :broken
      t.text :note
      t.references :procedure, index: true, foreign_key: true
      #t.references :factory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

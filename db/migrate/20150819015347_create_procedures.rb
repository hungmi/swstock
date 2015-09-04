class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.string :sourcing_type, :start_date, :customer, :material_spec
      t.integer :procedure_amount
      t.references :workpiece, index: true, foreign_key: true
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
class CreatePcWorkpieces < ActiveRecord::Migration
  def change
    create_table :pc_workpieces do |t|
      t.string :wp_type, :picnum, :spec

      t.timestamps null: false
    end
  end
end

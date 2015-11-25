class CreateWorkpieces < ActiveRecord::Migration
  def change
    create_table :workpieces do |t|
      t.string :wp_type, :picnum, :spec

      t.timestamps null: false
    end
  end
end

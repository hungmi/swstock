class CreateFactories < ActiveRecord::Migration
  def change
    create_table :factories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

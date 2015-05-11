class RemoveColumnFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :amount, :string
  end
end

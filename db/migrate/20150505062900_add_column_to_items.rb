class AddColumnToItems < ActiveRecord::Migration
  def change
    add_column :items, :oldPicnum, :string
    add_column :items, :note, :text
    add_column :items, :finishQty, :integer
    add_column :items, :unfinishQty, :integer
  end
end

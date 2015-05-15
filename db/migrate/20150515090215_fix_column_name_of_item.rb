class FixColumnNameOfItem < ActiveRecord::Migration
  def change
  	rename_column :items, :oldPicnum, :oldpicnum
  end
end

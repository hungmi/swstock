class ChangeNumbersToTextsOfItems < ActiveRecord::Migration
  def change
  	change_table :items do |t|
  		t.change :finishQty, :text
  		t.change :unfinishQty, :text
  		t.rename :finishQty, :finished
  		t.rename :unfinishQty, :unfinished
  	end
  end
end

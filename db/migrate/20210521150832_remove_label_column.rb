class RemoveLabelColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :labels, :category1
    remove_column :labels, :category2
    remove_column :labels, :category3
  end
end

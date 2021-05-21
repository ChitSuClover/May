class ChangeTaskColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :content, :text
  end
end

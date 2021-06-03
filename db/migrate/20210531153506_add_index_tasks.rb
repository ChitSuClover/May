class AddIndexTasks < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, [:title, :content, :expired_at, :status]
  end
end

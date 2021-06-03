class AddColumnPriporityToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :pripority, :integer
  end
end

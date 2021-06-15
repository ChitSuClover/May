class RenameColumnNameOfLabel < ActiveRecord::Migration[5.2]
  def change
    rename_column :labels, :pripority, :name
  end
end

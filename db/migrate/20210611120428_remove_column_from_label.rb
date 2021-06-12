class RemoveColumnFromLabel < ActiveRecord::Migration[5.2]
  def change
    remove_column :labels ,:status
  end
end

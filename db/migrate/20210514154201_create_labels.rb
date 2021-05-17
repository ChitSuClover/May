class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :pripority
      t.string :status
      t.string :category1
      t.string :category2
      t.string :category3
      t.timestamps
    end
  end
end

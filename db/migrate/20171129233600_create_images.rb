class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :name
      t.integer :width
      t.integer :height
      t.string :url

      t.timestamps
    end
  end
end

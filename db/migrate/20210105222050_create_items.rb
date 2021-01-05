class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image
      t.integer :points

      t.references :competition,foreign_key:true

      t.timestamps
    end
    add_index :items,[:competition_id,:created_at]
  end
end

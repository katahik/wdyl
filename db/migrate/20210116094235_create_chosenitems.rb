class CreateChosenitems < ActiveRecord::Migration[6.1]
  def change
    create_table :chosenitems do |t|
      t.string :session_id
      t.integer :item_id

      t.timestamps
    end
    add_foreign_key :chosenitems, :sessions, column: :session_id,primary_key: :session_id
    # 頻繁に検索することになるときは高速化のためのindexをする
    add_index :chosenitems, :session_id
    add_index :chosenitems, :item_id
    add_index :chosenitems, [:session_id,:item_id]
  end
end

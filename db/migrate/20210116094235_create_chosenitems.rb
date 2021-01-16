class CreateChosenitems < ActiveRecord::Migration[6.1]
  def change
    create_table :chosenitems do |t|
      t.integer :session_id
      t.integer :item_id

      t.timestamps
    end
    # 頻繁に検索することになるときは高速化のためのindexをする
    add_index :chosenitems, :session_id
    add_index :chosenitems, :item_id
    add_index :chosenitems, [:session_id,:item_id]
  end
end

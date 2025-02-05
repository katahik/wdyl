class AddSessionsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions, id: false do |t|
      t.string :session_id, :null => false, primary_key: true
      t.text :data
      t.timestamps
    end

    add_index :sessions, :session_id, :unique => true
    add_index :sessions, :updated_at
  end
end

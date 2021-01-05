class CreateCompetitions < ActiveRecord::Migration[6.1]
  def change
    create_table :competitions do |t|
      t.string :name
      t.date :period_start
      t.date :period_end

      t.timestamps
    end
  end
end

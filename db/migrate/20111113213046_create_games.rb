class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :play_date

      t.timestamps
    end
  end
end

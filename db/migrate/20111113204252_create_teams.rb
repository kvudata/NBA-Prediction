class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :short_name
      t.string :long_name

      t.timestamps
    end
  end
end

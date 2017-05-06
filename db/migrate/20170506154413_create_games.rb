class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer    :player_1_id, index: true, foreign_key: true
      t.integer    :player_2_id, index: true, foreign_key: true
      t.integer    :player_1_score
      t.integer    :player_2_score
      t.date       :date_played
      t.timestamps null: false
    end
  end
end

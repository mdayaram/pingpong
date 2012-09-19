class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :team1
      t.integer :team2
      t.integer :round
      t.integer :next
      t.integer :winner

      t.timestamps
    end
  end
end

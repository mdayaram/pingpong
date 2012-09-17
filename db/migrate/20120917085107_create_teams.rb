class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :members
      t.text :bio
      t.string :smack

      t.timestamps
    end
  end
end

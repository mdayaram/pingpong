class AddLoseImgToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :lose_img, :string
  end
end

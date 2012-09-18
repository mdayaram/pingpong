class AddSmackImgToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :smack_img, :string
  end
end

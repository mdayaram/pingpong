class AddWinImgToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :win_img, :string
  end
end

class AddBracketToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :bracket, :string
  end
end

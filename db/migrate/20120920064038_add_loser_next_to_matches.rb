class AddLoserNextToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :loser_next, :int
  end
end

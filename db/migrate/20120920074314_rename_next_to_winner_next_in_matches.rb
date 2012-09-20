class RenameNextToWinnerNextInMatches < ActiveRecord::Migration
  def change
      rename_column :matches, :next, :winner_next
  end
end

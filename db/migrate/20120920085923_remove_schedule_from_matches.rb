class RemoveScheduleFromMatches < ActiveRecord::Migration
  def up
    remove_column :matches, :schedule
  end

  def down
    add_column :matches, :schedule, :datetime
  end
end

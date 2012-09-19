class AddScheduleToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :schedule, :datetime
  end
end

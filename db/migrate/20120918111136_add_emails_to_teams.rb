class AddEmailsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :emails, :string
  end
end

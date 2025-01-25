class AddUpcomingDaysToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :upcoming_days, :integer, default: 3, null: false
  end
end

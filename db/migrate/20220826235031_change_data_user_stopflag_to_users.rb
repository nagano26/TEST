class ChangeDataUserStopflagToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :user_stopflag, :boolean
  end
end

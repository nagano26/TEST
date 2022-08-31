class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :username_kana, :string
    add_column :users, :user_stopflag, :string
    add_column :users, :user_logintime, :datetime
  end
end

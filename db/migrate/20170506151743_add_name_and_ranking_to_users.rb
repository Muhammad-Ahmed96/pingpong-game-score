class AddNameAndRankingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: "UserName"
    add_column :users, :ranking, :integer, default: 1000
  end
end

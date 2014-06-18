class AddRankingToDividendHistories < ActiveRecord::Migration
  def up
    add_column :dividend_histories, :ranking, :integer, :null => false, :default => 999
  end

  def down
    remove_column :dividend_histories, :ranking
  end
end

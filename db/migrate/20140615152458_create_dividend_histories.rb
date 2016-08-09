class CreateDividendHistories < ActiveRecord::Migration
  def change
    create_table :dividend_histories do |t|
      t.integer :fiscal_year , :null => false
      t.decimal :sre, :null => false, :default => 0
      t.decimal :scap, :null => false, :default => 0
      t.decimal :cash, :null => false, :default => 0
      t.decimal :total, :null => false, :default => 0
      t.date :stock_paymentdate
      t.date :cash_paymentdate

      t.timestamps
    end
  end
end

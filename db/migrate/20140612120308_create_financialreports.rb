class CreateFinancialreports < ActiveRecord::Migration
  def change
    create_table :financialreports do |t|
      t.integer :fiscal_year

      t.timestamps
    end
  end
end

class CreateMonthlyrevenuereports < ActiveRecord::Migration
  def change
    create_table :monthlyrevenuereports do |t|
      t.integer :fiscal_year, :null => false

      t.timestamps
    end
  end
end

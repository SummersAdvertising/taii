class CreateHistoryrevenuereports < ActiveRecord::Migration
  def change
    create_table :historyrevenuereports do |t|
      t.integer :fiscal_year

      t.timestamps
    end
  end
end

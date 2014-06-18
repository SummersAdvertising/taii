class CreateAnnualreports < ActiveRecord::Migration
  def change
    create_table :annualreports do |t|
      t.integer :fiscal_year

      t.timestamps
    end
  end
end

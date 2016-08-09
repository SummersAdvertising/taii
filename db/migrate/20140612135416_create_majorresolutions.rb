class CreateMajorresolutions < ActiveRecord::Migration
  def change
    create_table :majorresolutions do |t|
      t.integer :fiscal_year

      t.timestamps
    end
  end
end

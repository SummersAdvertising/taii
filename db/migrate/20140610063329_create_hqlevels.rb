class CreateHqlevels < ActiveRecord::Migration
  def change
    create_table :hqlevels do |t|
      t.string :name
      t.integer :level
      t.integer :parent

      t.timestamps
    end
  end
end

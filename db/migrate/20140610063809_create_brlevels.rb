class CreateBrlevels < ActiveRecord::Migration
  def change
    create_table :brlevels do |t|
      t.string :name
      t.integer :level
      t.integer :parent

      t.timestamps
    end
  end
end

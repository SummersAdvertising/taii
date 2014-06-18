class CreateMajorpolicies < ActiveRecord::Migration
  def change
    create_table :majorpolicies do |t|
      t.string :description

      t.timestamps
    end
  end
end

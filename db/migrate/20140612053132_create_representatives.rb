class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives do |t|
      t.string :division
      t.string :name
      t.text :phone
      t.text :fax
      t.text :mobile
      t.string :email
      t.integer :organization_id

      t.timestamps
    end
  end
end

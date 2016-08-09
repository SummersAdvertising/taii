class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :org_name
      t.text :address

      t.timestamps
    end
  end
end

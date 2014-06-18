class CreateBrproducts < ActiveRecord::Migration
  def change
    create_table :brproducts do |t|
      t.string :name
      t.integer :article_id
      t.references :brlevel, index: true

      t.timestamps
    end
  end
end

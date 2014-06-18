class CreateHqproducts < ActiveRecord::Migration
  def change
    create_table :hqproducts do |t|
      t.string :name
      t.integer :article_id
      t.references :hqlevel, index: true

      t.timestamps
    end
  end
end

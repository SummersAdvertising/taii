class CreateFinancialprojections < ActiveRecord::Migration
  def change
    create_table :financialprojections do |t|
      t.string :title
      t.integer :article_id

      t.timestamps
    end
  end
end

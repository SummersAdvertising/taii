class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.text :url_1
      t.text :url_2
      t.text :url_3

      t.timestamps
    end
  end
end

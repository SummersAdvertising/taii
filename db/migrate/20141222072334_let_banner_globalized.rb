class LetBannerGlobalized < ActiveRecord::Migration
  def self.up 
      Banner.create_translation_table!({
        :url_1 => :text,
        :url_2 => :text, 
         :url_3 => :text,
      }, {
        :migrate_data => true
    })
    
    remove_column :banners, :url_1
    remove_column :banners, :url_2
    remove_column :banners, :url_3

  end
  
  def self.down
  
    add_column :banners, :url_1, :text
    add_column :banners, :url_2, :text
    add_column :banners, :url_3, :text

    Banner.drop_translation_table! :migrate_data => true
    
  end
end

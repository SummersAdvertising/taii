class LetAnnouncementGlobalized < ActiveRecord::Migration
  def self.up 
      Announcement.create_translation_table!({
        :title => :string, 
      }, {
        :migrate_data => true
    })
    
    remove_column :announcements, :title

  end
  
  def self.down
  
    add_column :announcements, :title, :string

    Announcement.drop_translation_table! :migrate_data => true
    
  end
end

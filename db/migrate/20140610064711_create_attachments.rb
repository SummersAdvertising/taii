class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file_name
      t.string :content_type
      t.string :file_size
      t.string :attachable_type
      t.integer :attachable_id
      t.string :attachment
      t.integer :ranking,    default: 999, null: false
      
      t.timestamps
    end
  end
end

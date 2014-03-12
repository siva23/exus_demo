class AddAttachmentImageToPatients < ActiveRecord::Migration
  def self.up
    change_table :patients do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :patients, :image
  end
end

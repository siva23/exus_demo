class AddAttachmentImageToDoctors < ActiveRecord::Migration
  def self.up
    change_table :doctors do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :doctors, :image
  end
end

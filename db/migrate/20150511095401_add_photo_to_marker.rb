class AddPhotoToMarker < ActiveRecord::Migration
  def self.up
    add_attachment :markers, :photo
  end

  def self.down
    remove_attachment :markers, :photo
  end
end

class AddVideoFileToVideos < ActiveRecord::Migration
  def up
    add_attachment :videos, :video_file
  end
  
  def down
    remove_attachment :videos, :video_file
  end
end

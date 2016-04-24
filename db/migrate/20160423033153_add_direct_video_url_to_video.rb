class AddDirectVideoUrlToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :direct_video_url, :text
  end
end

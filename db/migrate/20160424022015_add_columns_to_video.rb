class AddColumnsToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :video_filename, :string
    add_column :videos, :video_type, :string
  end
end

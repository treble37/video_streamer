class Video < ActiveRecord::Base
  belongs_to :user
  has_attached_file :video_file, s3_permissions: private
  validates_attachment :video_file, presence: true, content_type: { content_type: "video/mp4" }
end

# == Schema Information
#
# Table name: videos
#
#  id                      :integer          not null, primary key
#  title                   :string
#  description             :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  video_file_file_name    :string
#  video_file_content_type :string
#  video_file_file_size    :integer
#  video_file_updated_at   :datetime
#

class Video < ActiveRecord::Base
  belongs_to :user
  has_attached_file :video_file
  validates_attachment :video_file, presence: true, content_type: { content_type: "video/mp4" }
end

# == Schema Information
#
# Table name: videos
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  length           :string
#  direct_video_url :text
#

class Video < ActiveRecord::Base
  belongs_to :user
end

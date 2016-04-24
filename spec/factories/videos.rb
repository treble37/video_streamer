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

FactoryGirl.define do
  factory :video do
    sequence(:title) { |n| "Title#{n}" }
    sequence(:description) { |n| "Description#{n}" }
    length "5:00"
    direct_video_url "http://www.s3.amazon.com/"
    sequence(:video_filename) { |n| "Video#{n}" }
    video_type "video/mp4"
    user
  end
end

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
#  length                  :string
#  direct_video_url        :text
#

FactoryGirl.define do
  factory :video do
    sequence(:title) { |n| "Title#{n}" }
    description "MyText"
    length "5:00"
    video_file { fixture_file_upload(File.join(Rails.root, "spec", "fixtures", "videos", "nature_clip.mp4"), "video/mp4") }
    user
  end
end

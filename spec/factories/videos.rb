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

FactoryGirl.define do
  factory :video do
    title "MyString"
    description "MyText"
    user_id 1
  end
end

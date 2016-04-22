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
#

require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should belong_to :user }
  it { should validate_attachment_presence(:video_file) }
  it { should validate_attachment_content_type(:video_file).
              allowing('video/mp4') }
end

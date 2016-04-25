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
#  video_filename   :string
#  video_type       :string
#

require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should belong_to :user }
end

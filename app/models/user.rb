# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :videos, dependent: :destroy
  validates_presence_of :first_name, :last_name
  accepts_nested_attributes_for :videos
end

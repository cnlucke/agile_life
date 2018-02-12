# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string
#  creator_id :integer
#  owner_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  has_many :memberships
  has_many :members, through: :memberships, source: :user
  has_many :tasks, class_name: 'Task'
  has_many :events, class_name: 'Event'
end

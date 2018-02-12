# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :created_tasks, class_name: 'Task', foreign_key: :creator_id
  has_many :created_events, class_name: 'Event', foreign_key: :creator_id
  has_many :owned_tasks, class_name: 'Task', foreign_key: :owner_id
  has_many :owned_events, class_name: 'Event', foreign_key: :owner_id
  has_secure_password
end

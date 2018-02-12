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
  # has_many :users, through: :memberships
  has_many :tasks, class_name: 'Task'
  has_many :events, class_name: 'Event'

  validates :name, uniqueness: true

  def add_member(user)
    members << user
    user.groups << self
    # Membership.create(user: user, group: self)
  end

  def remove_member(user)
    members.destroy(user)
    user.groups.destroy(self)
    # m = Membership.all.select { |m| m.user_id == user.id && m.group_id == self.id }
    # m.each { |m| m.destroy }
  end

  def has_member?(user)
    !members.find_by(id: user.id).nil?
  end
end

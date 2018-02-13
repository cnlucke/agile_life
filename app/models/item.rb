# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  type        :string
#  creator_id  :integer
#  group_id    :integer
#  owner_id    :integer
#  parent_id   :integer
#  title       :string
#  description :string
#  status      :string
#  notes       :text
#  starts_at   :datetime
#  ends_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ApplicationRecord
  scope :tasks, -> { where(type: 'Task') }
  scope :events, -> { where(type: 'Event') }

  def self.created(user)
    Item.all.select { |i| i.creator_id == user.id }
  end

  def self.owned(user)
    Item.all.select { |i| i.owner_id == user.id }
  end

  def children(item)
    Item.all.select { |i| i.parent_id == item.id && i.id != item.id }
  end
end

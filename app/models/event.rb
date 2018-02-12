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

class Event < Item
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, optional: true
  belongs_to :group, optional: true
  belongs_to :parent, class_name: 'Item', optional: true
  has_many :children, foreign_key: :parent_id, class_name: 'Item'
end

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

class Task < Item
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, optional: true
  belongs_to :group, optional: true
  belongs_to :parent, class_name: 'Item', optional: true
  has_many :children, foreign_key: :parent_id, class_name: 'Item'

  def self.in_progress
    self.all.select { |t| t.status == "in progress" }
  end

  def self.unassigned
    unassigned = User.find_by(name: "unassigned")
    self.all.select { |t| t.owner_id == unassigned.id }
  end

  def table_color(status)
    case status
    when "created"
      "table-warning"
    when "completed"
      "table-success"
    when "in progress"
      "table-info"
    when "blocked"
      "table-danger"
    else
      ""
    end
  end

  def self.statuses
    ["created", "in progress", "completed", "blocked"]
  end
end

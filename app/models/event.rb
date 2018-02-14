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

  def all_day?
    if starts_at.nil? && ends_at.nil?
      false
    else
      time = [starts_at.hour, starts_at.min, starts_at.sec, ends_at.hour, ends_at.min, ends_at.sec]
      (time.uniq.length == 1) && (time[0] == 0)
    end
<<<<<<< HEAD
=======
  end

  def set_all_day
    self.starts_at = self.starts_at.change({ hour: 0, min: 0, sec: 0 })
    self.ends_at = self.ends_at.change({ hour: 0, min: 0, sec: 0 })
    self.save
>>>>>>> b9f7228232160c79c0afd3a13110b67908b1f931
  end

end

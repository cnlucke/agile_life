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

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: memberships
#
#  id            :integer          not null, primary key
#  fee_paid      :boolean
#  tshirt        :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  member_id     :integer
#  period_id     :integer
#  who_signed_up :integer
#

require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

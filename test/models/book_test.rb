# == Schema Information
#
# Table name: books
#
#  id                  :integer          not null, primary key
#  title               :string
#  year                :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  publishing_house_id :integer
#  author_id           :integer
#

require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

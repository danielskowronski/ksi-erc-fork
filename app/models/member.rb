# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  name       :string
#  surname    :string
#  email      :string
#  card_id    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Member < ActiveRecord::Base
  validates :name, presence: true
  validates :surname, presence: true
  validates :email, presence: true, uniqueness: true,
            email_format: { message: "nie wydaje się być poprawnym emailem."}
  validates :card_id, uniqueness: true
end

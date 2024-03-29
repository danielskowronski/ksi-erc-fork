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
  validates :card_id, uniqueness: true, allow_blank: true,
            length: { is: 8, message: "ELS id musi mieć dokładnie 8 znaków!" }

  has_many :memberships
  accepts_nested_attributes_for :memberships

  has_many :roles, through: :memberships
  has_many :periods, through: :memberships
  has_one :comment

  has_many :book_lease
  has_many :lock_logs, foreign_key: 'card_id'

  def full_name(old_order=false)
    if old_order
      name + ' ' + surname
    else
      surname + ", " + name
    end
  end
end

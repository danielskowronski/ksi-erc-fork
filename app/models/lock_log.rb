class LockLog < ActiveRecord::Base
  has_one :member, foreign_key: 'card_id', primary_key: 'card_id'
end

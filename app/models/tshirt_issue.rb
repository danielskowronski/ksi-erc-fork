class TshirtIssue < ActiveRecord::Base
  belongs_to :member
  belongs_to :tshirt_definition
end

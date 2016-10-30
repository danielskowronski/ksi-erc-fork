json.extract! tshirt_issue, :id, :comment, :member_id, :tshirt_definition_id, :created_at, :updated_at
json.url tshirt_issue_url(tshirt_issue, format: :json)
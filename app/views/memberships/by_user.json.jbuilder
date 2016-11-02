json.array!(@memberships) do |membership|
  json.extract! membership, :id, :fee_paid, :fee_paid_html, :period_id, :role_ids
end

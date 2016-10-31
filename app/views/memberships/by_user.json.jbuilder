json.array!(@memberships) do |membership|
  json.extract! membership, :id, :fee_paid, :period_id, :role_ids
end

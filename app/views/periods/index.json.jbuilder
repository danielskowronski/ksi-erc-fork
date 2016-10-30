json.array!(@periods) do |period|
  json.extract! period, :id, :academic_year, :info, :fee
  #json.url period_url(period, format: :json)
end

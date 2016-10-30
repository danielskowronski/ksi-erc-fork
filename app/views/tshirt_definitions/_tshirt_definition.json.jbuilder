json.extract! tshirt_definition, :id, :name, :produced, :comments, :image, :created_at, :updated_at
json.url tshirt_definition_url(tshirt_definition, format: :json)
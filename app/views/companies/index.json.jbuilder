json.array!(@companies) do |company|
  json.extract! company, :id, :name, :bio, :slug, :photo
  json.url company_url(company, format: :json)
end

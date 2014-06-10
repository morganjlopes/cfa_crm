json.array!(@people) do |person|
  json.extract! person, :id, :name, :bio, :gender, :photo, :slug
  json.url person_url(person, format: :json)
end

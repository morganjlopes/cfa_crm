json.array!(@communities) do |community|
  json.extract! community, :id, :name, :subdomain, :owner_id, :logo, :is_active
  json.url community_url(community, format: :json)
end

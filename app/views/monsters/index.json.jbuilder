json.array!(@monsters) do |monster|
  json.extract! monster, :id, :name, :power, :type
  json.url monster_url(monster, format: :json)
end

json.array!(@targets) do |target|
  json.extract! target, :id, :email, :name, :role
  json.url target_url(target, format: :json)
end

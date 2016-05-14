json.array!(@mobilizations) do |mobilization|
  json.extract! mobilization, :id, :title, :category, :description, :mail_content
  json.url mobilization_url(mobilization, format: :json)
end

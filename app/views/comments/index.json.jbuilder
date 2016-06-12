json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :commenter_id, :commenter_type
  json.url comment_url(comment, format: :json)
end

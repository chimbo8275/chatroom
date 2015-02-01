json.array!(@messages) do |message|
  json.extract! message, :id, :room_id, :author_id, :body
  json.url message_url(message, format: :json)
end

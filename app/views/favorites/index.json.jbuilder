json.array!(@favorites) do |favorite|
  json.extract! favorite, :id, :article_id, :user_id
  json.url favorite_url(favorite, format: :json)
end

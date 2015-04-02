json.array!(@articles) do |article|
  json.extract! article, :id, :title, :description, :theme_id, :abstract, :user_id
  json.url article_url(article, format: :json)
end

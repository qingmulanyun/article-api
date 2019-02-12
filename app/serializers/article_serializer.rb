class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :date, :body, :tags
end

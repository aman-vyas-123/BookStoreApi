class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :price, :published_at, :user_id
end

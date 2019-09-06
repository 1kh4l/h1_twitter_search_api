module Types
  class EntityHashtagType < Types::BaseObject
    field :name, String, null: true
    field :content, [Types::HashtagType], null: true
  end
end

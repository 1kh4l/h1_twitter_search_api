module Types
  class EntityUrlType < Types::BaseObject
    field :name, String, null: true
    field :content, [Types::UrlType], null: true
  end
end

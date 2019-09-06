module Types
  class UrlType < Types::BaseObject
    field :url, String, null: true
    field :display_url, String, null: true
  end
end

module Types
  class UserType < Types::BaseObject
    field :id, String, null: false
    field :name, String, null: false
    field :account_name, String, null: false
    field :description, String, null: true
    field :photo_url, String, null: true
    field :followers, Integer, null: true
    field :friends, Integer, null: true
  end
end

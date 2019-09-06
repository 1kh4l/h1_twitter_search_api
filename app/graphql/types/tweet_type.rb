module Types
  class TweetType < Types::BaseObject
    field :id, String, null: true
    field :text, String, null: true
    field :date, String, null: true
    field :user, Types::UserType, null: false
  end
end

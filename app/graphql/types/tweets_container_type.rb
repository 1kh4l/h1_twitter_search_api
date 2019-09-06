module Types
  class TweetsContainerType < Types::BaseObject
    field :id, ID, null: false
    field :results, [Types::TweetType], null: true
    field :total_tweets, Integer, null: true
    field :top_hashtags, [Types::HashtagWithOcurrenceType], null:true
  end
end

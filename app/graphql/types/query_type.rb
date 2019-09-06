module Types
  class QueryType < Types::BaseObject
    # Helper module for managing Twitter API requests.
    include FormattedTweetsHelper
    #
    # (tweets) endpoint for getting Tweets info.
    #
    field :tweets, Types::TweetsContainerType, null: false do
      argument :search_param, String, required: true
      argument :limit, Integer, required: false
      argument :result_type, String, required: false
    end

    def tweets(search_param:, limit: 5, result_type: 'recent')
      # Twitter api client use for search tweets.
      # puts "Here goes the search param: "
      # puts search_param
      tweets = format_tweets(search_param, limit, result_type)
      tweets
    end

    #
    # (tweet) endpoint for getting Tweet info.
    #
    field :tweet, Types::TweetType, null: false do
      argument :id, ID, required: true
    end

    def tweet(id:)
      tweet = format_tweet(id)
      tweet
    end
  end
end

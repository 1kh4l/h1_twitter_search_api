class TweetsContainer
  include ActiveModel::AttributeMethods
  attr_accessor :results, :total_tweets, :top_hashtags
end

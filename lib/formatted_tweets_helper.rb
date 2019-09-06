module FormattedTweetsHelper
  def format_tweets(search_param, limit, result_type)
    tweets = []
    top_hashtags = []
    TWITTER_CLI.search(search_param, lang: 'en', result_type:result_type, tweet_mode: 'extended').take(limit).each do |e|
      tweet  = Tweet.new
      tweet.id = e.id
      tweet.text = e.attrs[:full_text]
      # User info
      tweet = handling_user(e, tweet)
      urls = e.attrs[:entities][:urls]
      hashtags = e.attrs[:entities][:hashtags]
      # If there are urls change them with appropiated display urls.
      if urls.length > 0
        tweet = handling_urls(urls, tweet)
      end
      # If there are hashtags just build their respective types.
      if hashtags.length > 0
        tweet = handling_hashtags(hashtags, tweet)
        # Also build the TOP 10
        top_hashtags = build_top_hashtags(tweet.hashtags[0].content, top_hashtags)
      end
      tweet.date = e.created_at
      tweet.likes = e.favorite_count
      tweet.rts = e.retweet_count
      if e.media.length > 0
        media = e.media[0].attrs
        tweet = handling_media(media, tweet)
      end
      tweets.push(tweet)
    end 
    container = TweetsContainer.new
    container.results = tweets
    container.total_tweets = tweets.length
    container.top_hashtags = top_hashtags.first(10)
    container
  end

  def build_top_hashtags(hashtags, top_hashtags)
    len = hashtags.length
    i = 0
    while i < len
      match = top_hashtags.select { |hashtag| hashtag.name === hashtags[i].text }
      if match.length > 0
        index = top_hashtags.index(match[0])
        top_hashtags[index].ocurrences += 1
      else
        new_hashtag = HashtagWithOcurrence.new
        new_hashtag.name = hashtags[i].text
        new_hashtag.ocurrences = 1
        top_hashtags.push(new_hashtag)
      end
      i+=1
    end
    top_hashtags
  end

  def handling_urls(urls, tweet)
    url_entity = Entity.new
    url_entity.name = 'urls'
    url_entity.content = []
    tweet.text, url_entity.content = setting_text_and_urls(urls, tweet.text)
    tweet.text_urls = []
    tweet.text_urls.push(url_entity)
    tweet
  end

  def handling_hashtags(hashtags, tweet)
    hashtag_entity = Entity.new
    hashtag_entity.name = "hashtags"
    hashtag_entity.content = []
    hashtag_entity.content = get_hashtags(hashtags)
    tweet.hashtags = []
    tweet.hashtags.push(hashtag_entity)
    tweet
  end

  def handling_media(media, tweet)
    if media[:type] === 'photo'
      tweet.photo_url = media[:media_url]
      tweet.photo_short_url = media[:url]
      tweet.photo_link_twitter = media[:display_url] || media[:expanded_url]
    elsif media[:type] === 'video'
      tweet.video_url = media[:media_url]
      tweet.video_short_url = media[:url]
      tweet.video_link_twitter = media[:display_url] || media[:expanded_url]
    elsif media[:type] === 'animated_gif'
      tweet.gif_url = media[:video_info][:variants][0][:url]
      tweet.gif_short_url = media[:url]
      tweet.gif_link_twitter = media[:display_url] || media[:expanded_url]
    end
    tweet
  end

  def format_tweet(id)
    tweet = Tweet.new
    tweet_response = TWITTER_CLI.statuses(id, tweet_mode: 'extended')[0]
    tweet.id = tweet_response.id
    tweet.text = tweet_response.attrs[:full_text]
    # Setting user info
    tweet = handling_user(tweet_response, tweet)
    urls = tweet_response.attrs[:entities][:urls]
    hashtags = tweet_response.attrs[:entities][:hashtags]
    # If there are urls change them with appropiated display urls.
    if urls.length > 0
      tweet = handling_urls(urls, tweet)
    end
    # If there are hashtags just build their respective types.
    if hashtags.length > 0
      tweet = handling_hashtags(hashtags, tweet)
    end
    # If there's photo, video or gif
    if tweet_response.media.length > 0
      media = tweet_response.media[0].attrs
      tweet = handling_media(media, tweet)
    end
    tweet.date = tweet_response.attrs[:created_at]
    tweet.likes = tweet_response.attrs[:favorite_count]
    tweet.rts = tweet_response.attrs[:retweet_count]
    tweet
  end

  def handling_user(response, tweet)
    user = User.new
    user.id = response.user.id
    user.name = response.user.name
    user.account_name = response.user.screen_name
    user.description = response.user.description
    user.followers = response.user.followers_count
    user.friends = response.user.friends_count
    user.photo_url = response.user.profile_image_url
    tweet.user = user
    tweet
  end

  def setting_text_and_urls(entities, text)
    new_text = ''
    urls = []
    entities.each do |url_info|
      url_entity = Url.new
      url = url_info[:url]
      url_entity.url = url
      display_url = url_info[:display_url]
      url_entity.display_url = display_url
      urls.push(url_entity)
      if text.include? url
        new_text = text.gsub(url, display_url)
      end
    end
    return new_text, urls
  end

  def get_hashtags(hashtags)
    hash_tags = []
    hashtags.each do |hashtag_info|
      hashtag_entity = Hashtag.new
      text = hashtag_info[:text]
      indices = hashtag_info[:indices]
      hashtag_entity.text, hashtag_entity.indices = text, indices
      hash_tags.push(hashtag_entity)
    end 
    hash_tags
  end
end

class Tweet
  include ActiveModel::AttributeMethods

  # Tweet's basic info.
  attr_accessor :id, :text, :date, :user
  # Tweet's info help
  attr_accessor :text_urls, :hashtags
  # Favs and RTs Tweet's info.
  attr_accessor :likes, :rts
  # Tweet's media info
  attr_accessor :photo_url, :photo_short_url, :photo_link_twitter
  attr_accessor :video_url, :video_short_url, :video_link_twitter
  attr_accessor :gif_url, :gif_short_url, :gif_link_twitter

end

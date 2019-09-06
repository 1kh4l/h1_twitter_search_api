module Types
  class TweetType < Types::BaseObject
    field :id, String, null: true
    field :text, String, null: true
    field :date, String, null: true
    field :likes, Integer, null: true
    field :rts, Integer, null: true
    field :photo_url, String, null: true
    field :photo_short_url, String, null: true
    field :photo_link_twitter, String, null: true
    field :video_url, String, null: true
    field :video_short_url, String, null: true
    field :video_link_twitter, String, null: true
    field :gif_url, String, null: true
    field :gif_short_url, String, null: true
    field :gif_link_twitter, String, null: true
    field :text_urls, [Types::EntityUrlType], null: true
    field :hashtags, [Types::EntityHashtagType], null: true
    field :user, Types::UserType, null: false
  end
end

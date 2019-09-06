class Tweet
  include ActiveModel::AttributeMethods

  # Tweet's basic info.
  attr_accessor :id, :text, :date, :user
end

class User
  include ActiveModel::AttributeMethods
  ## User properties.
  attr_accessor :id, :name, :account_name, :description, :photo_url
  attr_accessor :followers, :friends
end

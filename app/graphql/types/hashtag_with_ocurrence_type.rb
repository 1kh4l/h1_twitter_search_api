module Types
  class HashtagWithOcurrenceType < Types::BaseObject
    field :name, String, null: true
    field :ocurrences, Integer, null:true
  end
end

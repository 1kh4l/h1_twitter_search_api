module Types
  class HashtagType < Types::BaseObject
    field :text, String, null: true
    field :indices, [Integer], null: true
  end
end

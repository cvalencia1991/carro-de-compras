class Types::UserType < Types::BaseObject
  field :id, ID, null: false
  field :name, String
  field :emailAddress, String, null: false, method: :email
end

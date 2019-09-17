class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :api_key
  
  attributes :errors do |obj|
    obj.errors.full_messages.to_sentence
  end
end

class GifsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :images
end

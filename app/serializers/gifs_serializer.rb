class GifsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :images
  attributes :copyright do |obj|
    obj = Date.today.strftime("%Y")
  end
end

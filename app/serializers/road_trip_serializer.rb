class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :travel_time

  attribute :forecast do |obj|
    obj.forecast.currently
  end
end

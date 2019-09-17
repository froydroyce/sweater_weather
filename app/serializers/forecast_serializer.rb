class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :forecast
end

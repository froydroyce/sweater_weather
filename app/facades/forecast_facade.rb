class ForecastFacade
  attr_reader :id

  def initialize(city_state)
    @city_state = city_state
  end

  def location
    Location.new(geolocation(@city_state)[:results][0])
  end

  def forecast
    Forecast.new(forecast_for(location))
  end

  def future_forecast(arrival_time)
    Forecast.new(future_forecast_for(location, arrival_time))
  end

  private

  def geolocation(city_state)
    geo_service.location_by_city_state(city_state)
  end

  def forecast_for(location)
    darksky_service.forecast_by(location)
  end

  def future_forecast_for(location, arrival_time)
    darksky_service.future_forecast_by(location, arrival_time)
  end

  def geo_service
    @_geo_service ||= GeocodeService.new
  end

  def darksky_service
    @_darksky_service ||= DarkskyService.new
  end
end

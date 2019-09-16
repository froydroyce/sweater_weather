class ForecastFacade
  attr_reader :id
  
  def initialize(city_state)
    @id = nil
    @city_state = city_state
  end

  def location
    Location.new(geolocation(@city_state)[:results][0])
  end

  def forecast
    Forecast.new(forecast_for(location))
  end

  def images
    forecast.daily[0..4].map do |daily|
      Gif.new(daily[:time], daily[:summary], gifs_for(daily[:summary]))
    end
  end

  private

  def geolocation(city_state)
    geo_service.location_by_city_state(city_state)
  end

  def forecast_for(location)
    darksky_service.forecast_by(location)
  end

  def gifs_for(summary)
    giphy_service.gifs_by(summary)
  end

  def giphy_service
    @_giphy_service ||= GiphyService.new
  end

  def geo_service
    @_geo_service ||= GeocodeService.new
  end

  def darksky_service
    @_darksky_service ||= DarkskyService.new
  end
end

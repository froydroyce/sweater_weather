class RoadTripFacade
  attr_reader :id

  def initialize(params)
    @origin = params[:origin]
    @destination = params[:destination]
  end

  def travel_time
    TravelTime.new(directions_for(@origin, @destination))
  end

  def arrival_time
    Time.now.to_i + travel_time.duration[:value]
  end

  def forecast
    forecast_facade.future_forecast(arrival_time)
  end

  private

  def directions_for(origin, destination)
    @_directions ||= google_service.directions_by(origin, destination)
  end

  def google_service
    GoogleService.new
  end

  def forecast_facade
    ForecastFacade.new(@destination)
  end
end

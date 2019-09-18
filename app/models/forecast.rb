class Forecast
  attr_reader :currently, :today, :hourly, :tonight, :daily
  def initialize(attr)
    @currently = attr[:currently]
    @today = attr[:daily][:data][0]
    @hourly = attr[:hourly][:data]
    @tonight = tonight[0]
    @daily = attr[:daily][:data]
  end

  def tonight
    @hourly.select { |data| data[:time] == night_time }
  end

  def night_time
    t = Time.now
    DateTime.new(t.year, t.month, t.day, 20, 0, 0, t.zone).to_time.to_i
  end
end

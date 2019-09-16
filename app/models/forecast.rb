class Forecast
  attr_reader :currently, :today, :hourly, :tonight, :daily
  def initialize(attr)
    @currently = attr[:currently]
    @today = attr[:daily][:data][0]
    @hourly = attr[:hourly][:data][0..7]
    @tonight = tonight[0]
    @daily = attr[:daily][:data]
  end

  def tonight
    binding.pry
    @hourly.select { |data| data[:time] == night_time }
  end

  def night_time
    DateTime.new(
      Time.now.year,
      Time.now.month,
      Time.now.day,
      20,
      0,
      0,
      Time.now.zone
    ).to_time.to_i
  end
end

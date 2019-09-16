require "rails_helper"

describe Forecast do
  it "exists" do
    dark_response = File.read("./fixtures/denver_darksky.json")
    attr = JSON.parse(dark_response, symbolize_names: true)
    forecast = Forecast.new(attr)

    expect(forecast).to be_a Forecast
    expect(forecast.currently.count).to eq(19)
    expect(forecast.today.count).to eq(39)
    expect(forecast.hourly.count).to eq(8)
    expect(forecast.tonight[0].count).to eq(18)
    expect(forecast.daily.count).to eq(8)
  end
end

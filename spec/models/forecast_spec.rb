require "rails_helper"

describe Forecast do
  it "exists" do
    dark_response = File.read("./fixtures/denver_darksky.json")
    attr = JSON.parse(dark_response, symbolize_names: true)
    allow_any_instance_of(Forecast).to receive(:tonight).and_return(
      [{"time"=>1568599200,
      "summary"=>"Mostly Cloudy",
      "icon"=>"partly-cloudy-night",
      "precipIntensity"=>0.0005,
      "precipProbability"=>0.01,
      "precipType"=>"rain",
      "temperature"=>84.13,
      "apparentTemperature"=>84.13,
      "dewPoint"=>32.1,
      "humidity"=>0.15,
      "pressure"=>1009.77,
      "windSpeed"=>8.14,
      "windGust"=>14.16,
      "windBearing"=>171,
      "cloudCover"=>0.76,
      "uvIndex"=>0,
      "visibility"=>10,
      "ozone"=>279.2}]
    )
    forecast = Forecast.new(attr)

    expect(forecast).to be_a Forecast
    expect(forecast.currently.count).to eq(19)
    expect(forecast.today.count).to eq(39)
    expect(forecast.hourly.count).to eq(8)
    expect(forecast.tonight[0].count).to eq(18)
    expect(forecast.daily.count).to eq(8)
  end
end

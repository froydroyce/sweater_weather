require 'rails_helper'

describe 'Forecast API' do
  it "gets weather for a city, state" do
    geo_response = File.open("./fixtures/denver_geocode.json")
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_KEY']}").
      to_return(status: 200, body: geo_response)
    dark_response = File.open("./fixtures/denver_darksky.json")
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API']}/39.7392358,-104.990251").
      to_return(status: 200, body: dark_response)
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

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
    forecast = JSON.parse(response.body)

    expect(forecast["data"].count).to eq(3)
    expect(forecast["data"]["attributes"]["location"]["city"]).to eq("Denver")
    expect(forecast["data"]["attributes"]["location"]["state"]).to eq("CO")
    expect(forecast["data"]["attributes"]["location"]["country"]).to eq("United States")
    expect(forecast["data"]["attributes"]["forecast"]["currently"]["icon"]).to eq("partly-cloudy-day")
    expect(forecast["data"]["attributes"]["forecast"]["currently"]["time"]).to eq(1568574824)
    expect(forecast["data"]["attributes"]["forecast"]["currently"]["summary"]).to eq("Mostly Cloudy")
    expect(forecast["data"]["attributes"]["forecast"]["currently"]["temperature"]).to eq(86.02)
    expect(forecast["data"]["attributes"]["forecast"]["currently"]["apparentTemperature"]).to eq(86.02)
    expect(forecast["data"]["attributes"]["forecast"]["currently"]["humidity"]).to eq(0.11)
    expect(forecast["data"]["attributes"]["forecast"]["currently"]["visibility"]).to eq(4.399)
    expect(forecast["data"]["attributes"]["forecast"]["currently"]["uvIndex"]).to eq(5)
    expect(forecast["data"]["attributes"]["forecast"]["today"]["summary"]).to eq("Mostly cloudy throughout the day.")
    expect(forecast["data"]["attributes"]["forecast"]["today"]["icon"]).to eq("partly-cloudy-day")
    expect(forecast["data"]["attributes"]["forecast"]["tonight"]["summary"]).to eq("Mostly Cloudy")
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][0]["temperature"]).to eq(85.41)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][0]["time"]).to eq(1568574000)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][1]["temperature"]).to eq(88.08)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][1]["time"]).to eq(1568577600)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][2]["temperature"]).to eq(90.66)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][2]["time"]).to eq(1568581200)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][3]["temperature"]).to eq(92.19)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][3]["time"]).to eq(1568584800)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][4]["temperature"]).to eq(92.23)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][4]["time"]).to eq(1568588400)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][5]["temperature"]).to eq(91.2)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][5]["time"]).to eq(1568592000,)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][6]["temperature"]).to eq(88.05)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][6]["time"]).to eq(1568595600)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][7]["temperature"]).to eq(84.13)
    expect(forecast["data"]["attributes"]["forecast"]["hourly"][7]["time"]).to eq(1568599200)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][0]["time"]).to eq(1568527200)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][0]["humidity"]).to eq(0.23)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][0]["temperatureHigh"]).to eq(92.23)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][0]["temperatureLow"]).to eq(63.89)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][1]["time"]).to eq(1568613600)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][1]["humidity"]).to eq(0.27)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][1]["temperatureHigh"]).to eq(86.94)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][1]["temperatureLow"]).to eq(63)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][2]["time"]).to eq(1568700000)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][2]["humidity"]).to eq(0.32)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][2]["temperatureHigh"]).to eq(83.16)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][2]["temperatureLow"]).to eq(56.99)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][3]["time"]).to eq(1568786400)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][3]["humidity"]).to eq(0.33)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][3]["temperatureHigh"]).to eq(83.4)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][3]["temperatureLow"]).to eq(58.97)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][4]["time"]).to eq(1568872800)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][4]["humidity"]).to eq(0.36)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][4]["temperatureHigh"]).to eq(83.88)
    expect(forecast["data"]["attributes"]["forecast"]["daily"][4]["temperatureLow"]).to eq(55.62)
  end
end

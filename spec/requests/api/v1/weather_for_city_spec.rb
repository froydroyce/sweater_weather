require 'rails_helper'

describe 'Forecast API' do
  it "gets weather for a city, state" do
    geo_response = File.open("./fixtures/denver_geocode.json")
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Denver, CO&key=#{ENV['GOOGLE_KEY']}").
      to_return(status: 200, body: geo_response)

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
    forecast = JSON.parse(response.body)

    expect(forecast["data"].count).to eq(2)
    expect(forecast["data"]["location"]["city"]).to eq("Denver")
    expect(forecast["data"]["location"]["state"]).to eq("CO")
    expect(forecast["data"]["location"]["country"]).to eq("United States")
    expect(forecast["data"]["forecast"]["currently"]["icon"]).to eq("partly-cloudy-day")
    expect(forecast["data"]["forecast"]["currently"]["time"]).to eq("1:13")
    expect(forecast["data"]["forecast"]["currently"]["date"]).to eq("09/15")
    expect(forecast["data"]["forecast"]["currently"]["summary"]).to eq("Mostly Cloudy")
    expect(forecast["data"]["forecast"]["currently"]["temperature"]).to eq(86.02)
    expect(forecast["data"]["forecast"]["currently"]["apparentTemperature"]).to eq(86.02)
    expect(forecast["data"]["forecast"]["currently"]["humidity"]).to eq(0.11)
    expect(forecast["data"]["forecast"]["currently"]["visibility"]).to eq(4.399)
    expect(forecast["data"]["forecast"]["currently"]["uvIndex"]).to eq(5)
    expect(forecast["data"]["forecast"]["today"]["summary"]).to eq("Mostly cloudy throughout the day.")
    expect(forecast["data"]["forecast"]["today"]["icon"]).to eq("partly-cloudy-day")
    expect(forecast["data"]["forecast"]["tonight"]["summary"]).to eq("Mostly Cloudy")
    expect(forecast["data"]["forecast"]["hourly"][0]["temperature"]).to eq(85.41)
    expect(forecast["data"]["forecast"]["hourly"][1]["temperature"]).to eq(88.08)
    expect(forecast["data"]["forecast"]["hourly"][2]["temperature"]).to eq(90.66)
    expect(forecast["data"]["forecast"]["hourly"][3]["temperature"]).to eq(92.19)
    expect(forecast["data"]["forecast"]["hourly"][4]["temperature"]).to eq(92.23)
    expect(forecast["data"]["forecast"]["hourly"][5]["temperature"]).to eq(91.2)
    expect(forecast["data"]["forecast"]["hourly"][6]["temperature"]).to eq(88.05)
    expect(forecast["data"]["forecast"]["hourly"][7]["temperature"]).to eq(84.13)
    expect(forecast["data"]["forecast"]["daily"][0]["day"]).to eq("Sunday")
    expect(forecast["data"]["forecast"]["daily"][0]["humidity"]).to eq(0.23)
    expect(forecast["data"]["forecast"]["daily"][0]["temperatureHigh"]).to eq(92.23)
    expect(forecast["data"]["forecast"]["daily"][0]["temperatureLow"]).to eq(63.89)
    expect(forecast["data"]["forecast"]["daily"][1]["day"]).to eq("Monday")
    expect(forecast["data"]["forecast"]["daily"][1]["humidity"]).to eq(0.27)
    expect(forecast["data"]["forecast"]["daily"][1]["temperatureHigh"]).to eq(86.94)
    expect(forecast["data"]["forecast"]["daily"][1]["temperatureLow"]).to eq(63)
    expect(forecast["data"]["forecast"]["daily"][2]["day"]).to eq("Tuesday")
    expect(forecast["data"]["forecast"]["daily"][2]["humidity"]).to eq(0.32)
    expect(forecast["data"]["forecast"]["daily"][2]["temperatureHigh"]).to eq(83.16)
    expect(forecast["data"]["forecast"]["daily"][2]["temperatureLow"]).to eq(56.99)
    expect(forecast["data"]["forecast"]["daily"][3]["day"]).to eq("Wednesday")
    expect(forecast["data"]["forecast"]["daily"][3]["humidity"]).to eq(0.33)
    expect(forecast["data"]["forecast"]["daily"][3]["temperatureHigh"]).to eq(83.4)
    expect(forecast["data"]["forecast"]["daily"][3]["temperatureLow"]).to eq(58.97)
    expect(forecast["data"]["forecast"]["daily"][4]["day"]).to eq("Thursday")
    expect(forecast["data"]["forecast"]["daily"][4]["humidity"]).to eq(0.36)
    expect(forecast["data"]["forecast"]["daily"][4]["temperatureHigh"]).to eq(83.88)
    expect(forecast["data"]["forecast"]["daily"][4]["temperatureLow"]).to eq(55.62)
  end
end

# tonight = DateTime.new(Time.now.year, Time.now.month, Time.now.day, 20, 0, 0, Time.now.zone)

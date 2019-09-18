require "rails_helper"

describe "Road Trip" do
  it "returns road trip data" do
    directions_response = File.open("./fixtures/denver_roadtrip.json")
    stub_request(:get, "https://maps.googleapis.com/maps/api/directions/json?destination=Pueblo,CO&key=#{ENV['GOOGLE_KEY']}&origin=Denver,CO").
      to_return(status: 200, body: directions_response)
    geo_response = File.open("./fixtures/pueblo_geocode.json")
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Pueblo,CO&key=#{ENV['GOOGLE_KEY']}").
      to_return(status: 200, body: geo_response)
    dark_response = File.open("./fixtures/pueblo_darksky.json")
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API']}/38.2544472,-104.6091409,1568581207 ").
      to_return(status: 200, body: dark_response)
    allow_any_instance_of(Time).to receive(:to_i).and_return(1568574824)
    user = User.create!(
      email: "whatchamacallit@example.com",
      password: "password"
    )

    body = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "#{user.api_key}"
    }

    post "/api/v1/road_trip", params: body

    expect(response).to be_successful
    road_trip = JSON.parse(response.body)

    expect(road_trip["data"].count).to eq(3)
    expect(road_trip["data"]["attributes"]["travel_time"]["duration"]["text"]).to eq("1 hour 46 mins")
    expect(road_trip["data"]["attributes"]["forecast"]["time"]).to eq(1568581207)
    expect(road_trip["data"]["attributes"]["forecast"]["summary"]).to eq("Clear")
  end

  it "does not return an api_key" do
    User.create!(
      email: "whatchamacallit@example.com",
      password: "password"
    )

    body = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "notarealapikey"
    }

    post "/api/v1/road_trip", params: body

    expect(response).to_not be_successful
    road_trip = JSON.parse(response.body)

    expect(road_trip["error"]).to eq("Invalid or no api_key")
  end
end

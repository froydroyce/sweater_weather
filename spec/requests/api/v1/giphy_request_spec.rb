require "rails_helper"

describe 'Giphy API' do
  it "gets gif's using daily forecast summaries" do
    geo_response = File.open("./fixtures/denver_geocode.json")
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_KEY']}").
      to_return(status: 200, body: geo_response)
    dark_response = File.open("./fixtures/denver_darksky.json")
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API']}/39.7392358,-104.990251").
      to_return(status: 200, body: dark_response)

    get "/api/v1/gifs?location=denver,co"

    expect(response).to be_successful
    gifs = JSON.parse(response.body)

    
  end
end

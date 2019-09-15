require 'rails_helper'

describe 'Google Geocoding API' do
  it "gets latitude and longitude by city and state" do
    json_response = File.open("./fixtures/denver_geocode.json")
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Denver, CO&key=#{ENV['GOOGLE_KEY']}").
      to_return(status: 200, body: json_response)


  end
end

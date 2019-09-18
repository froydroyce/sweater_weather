require 'rails_helper'

describe GoogleService do
  context 'instance methods' do
    it "returns geolocation data" do
      geo_response = File.open("./fixtures/denver_geocode.json")
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_KEY']}").
        to_return(status: 200, body: geo_response)
      geolocation = subject.location_by_city_state('denver,co')

      expect(geolocation).to be_an Hash
      expect(geolocation.first).to be_a Array
      expect(geolocation[:results][0].count).to eq(5)
      expect(geolocation[:results][0]).to have_key(:address_components)
      expect(geolocation[:results][0]).to have_key(:formatted_address)
      expect(geolocation[:results][0]).to have_key(:geometry)
      expect(geolocation[:results][0]).to have_key(:place_id)
      expect(geolocation[:results][0]).to have_key(:types)
    end

    it "returns directions data" do
      directions_response = File.open("./fixtures/denver_roadtrip.json")
      stub_request(:get, "https://maps.googleapis.com/maps/api/directions/json?destination=Pueblo,CO&key=#{ENV['GOOGLE_KEY']}&origin=Denver,CO").
        to_return(status: 200, body: directions_response)
      directions = subject.directions_by('Denver,CO', 'Pueblo,CO')

      expect(directions).to be_an Hash
      expect(directions.first).to be_a Array
      expect(directions[:routes][0].count).to eq(7)
      expect(directions[:routes][0][:legs][0]).to have_key(:duration)
    end
  end
end

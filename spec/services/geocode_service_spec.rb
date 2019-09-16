require 'rails_helper'

describe GeocodeService do
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
  end
end

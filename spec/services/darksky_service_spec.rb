require 'rails_helper'

describe DarkskyService do
  context 'instance methods' do
    it "returns forecast data" do
      dark_response = File.open("./fixtures/denver_darksky.json")
      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API']}/39.7392358,-104.990251").
        to_return(status: 200, body: dark_response)
      response = File.read("./fixtures/denver_geocode.json")
      attr = JSON.parse(response, symbolize_names: true)

      location = Location.new(attr[:results][0])
      forecast = subject.forecast_by(location)

      expect(forecast).to be_an Hash
      expect(forecast.count).to eq(9)
      expect(forecast).to have_key(:latitude)
      expect(forecast).to have_key(:longitude)
      expect(forecast).to have_key(:timezone)
      expect(forecast).to have_key(:currently)
      expect(forecast).to have_key(:minutely)
      expect(forecast).to have_key(:hourly)
      expect(forecast).to have_key(:daily)
    end
  end
end

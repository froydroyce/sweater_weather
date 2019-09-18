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

    it "returns future forecast data" do
      dark_response = File.open("./fixtures/pueblo_darksky.json")
      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API']}/38.2544472,-104.6091409,1568581207").
        to_return(status: 200, body: dark_response)
      allow_any_instance_of(Time).to receive(:to_i).and_return(1568574824)

      response = File.read("./fixtures/pueblo_geocode.json")
      attr = JSON.parse(response, symbolize_names: true)

      location = Location.new(attr[:results][0])
      forecast = subject.future_forecast_by(location, 1568581207)

      expect(forecast).to be_an Hash
      expect(forecast.count).to eq(8)
      expect(forecast).to have_key(:latitude)
      expect(forecast).to have_key(:longitude)
      expect(forecast).to have_key(:timezone)
      expect(forecast).to have_key(:currently)
      expect(forecast).to have_key(:hourly)
      expect(forecast).to have_key(:daily)
    end
  end
end

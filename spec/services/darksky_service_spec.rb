require 'rails_helper'

describe DarkskyService do
  context 'instance methods' do
    it "returns forecast data" do
      dark_response = File.open("./fixtures/denver_darksky.json")
      stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API']}/39.7392358,-104.990251").
        to_return(status: 200, body: dark_response)

      attr = {
        :address_components=>
          [{:long_name=>"Denver", :short_name=>"Denver", :types=>["locality", "political"]},
            {:long_name=>"Denver County", :short_name=>"Denver County", :types=>["administrative_area_level_2", "political"]},
            {:long_name=>"Colorado", :short_name=>"CO", :types=>["administrative_area_level_1", "political"]},
            {:long_name=>"United States", :short_name=>"US", :types=>["country", "political"]}],
          :formatted_address=>"Denver, CO, USA",
          :geometry=>
            {:bounds=>{:northeast=>{:lat=>39.91424689999999, :lng=>-104.6002959}, :southwest=>{:lat=>39.614431, :lng=>-105.109927}},
              :location=>{:lat=>39.7392358, :lng=>-104.990251},
              :location_type=>"APPROXIMATE",
              :viewport=>{:northeast=>{:lat=>39.91424689999999, :lng=>-104.6002959}, :southwest=>{:lat=>39.614431, :lng=>-105.109927}}},
          :place_id=>"ChIJzxcfI6qAa4cR1jaKJ_j0jhE",
          :types=>["locality", "political"]
        }

      location = Location.new(attr)
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

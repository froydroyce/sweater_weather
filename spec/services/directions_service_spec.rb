require 'rails_helper'

describe DirectionsService do
  context 'instance methods' do
    it "returns directions data" do
      directions_response = File.open("./fixtures/denver_roadtrip.json")
      stub_request(:get, "https://maps.googleapis.com/api/directions/json?destination=Pueblo,CO&key=#{ENV['GOOGLE_KEY']}&origin=Denver,CO").
        to_return(status: 200, body: directions_response)
      directions = subject.directions_by('Denver,CO', 'Pueblo,CO')

      expect(directions).to be_an Hash
      expect(directions.first).to be_a Array
      expect(directions[:routes][0].count).to eq(7)
      expect(directions[:routes][0][:legs][0]).to have_key(:duration)
    end
  end
end

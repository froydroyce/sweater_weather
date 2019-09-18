require "rails_helper"

describe TravelTime do
  it "exists" do
    directions_response = File.read("./fixtures/denver_roadtrip.json")
    attr = JSON.parse(directions_response, symbolize_names: true)

    travel_time = TravelTime.new(attr)

    expect(travel_time).to be_a TravelTime
    expect(travel_time.duration).to eq({:text=>"1 hour 46 mins", :value=>6383})
  end
end

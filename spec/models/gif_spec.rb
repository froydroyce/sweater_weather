require "rails_helper"

describe Gif do
  it "exists" do
    mostly_cloudy = File.read("./fixtures/mostly_cloudy.json")
    giphy = JSON.parse(mostly_cloudy, symbolize_name: true)
    gif = Gif.new(1568527200, "Mostly cloudy throughout the day.", giphy)

    expect(gif).to be_a Gif
    expect(gif.time).to eq(1568527200)
    expect(gif.summary).to eq("Mostly cloudy throughout the day.")
    expect(gif.url).to eq("https://giphy.com/gifs/dark-castle-63xBFHKNVjZlu")
  end
end

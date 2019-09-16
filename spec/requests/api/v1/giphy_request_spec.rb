require "rails_helper"

describe 'Giphy API' do
  it "gets gif's using daily forecast summaries" do
    geo_response = File.open("./fixtures/denver_geocode.json")
    stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_KEY']}").
      to_return(status: 200, body: geo_response)
    dark_response = File.open("./fixtures/denver_darksky.json")
    stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API']}/39.7392358,-104.990251").
      to_return(status: 200, body: dark_response)
    mostly_response = File.open("./fixtures/mostly_cloudy.json")
    stub_request(:get, "https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_KEY']}&limit=1&q=Mostly%20cloudy%20throughout%20the%20day.").
      to_return(status: 200, body: mostly_response)
    partly_response = File.open("./fixtures/partly_cloudy.json")
    stub_request(:get, "https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_KEY']}&limit=1&q=Partly%20cloudy%20throughout%20the%20day.").
      to_return(status: 200, body: partly_response)
      
    get "/api/v1/gifs?location=denver,co"

    expect(response).to be_successful
    gifs = JSON.parse(response.body)

    expect(gifs["data"].count).to eq(3)
    expect(gifs["data"]["attributes"]).to have_key("images")
    expect(gifs["data"]["attributes"]["images"]).to be_a Array
    expect(gifs["data"]["attributes"]["images"][0]["time"]).to eq(1568527200)
    expect(gifs["data"]["attributes"]["images"][0]["summary"]).to eq("Mostly cloudy throughout the day.")
    expect(gifs["data"]["attributes"]["images"][0]["url"]).to eq("https://giphy.com/gifs/dark-castle-63xBFHKNVjZlu")
    expect(gifs["data"]["attributes"]["images"][1]["time"]).to eq(1568613600)
    expect(gifs["data"]["attributes"]["images"][1]["summary"]).to eq("Partly cloudy throughout the day.")
    expect(gifs["data"]["attributes"]["images"][1]["url"]).to eq("https://giphy.com/gifs/beach-clouds-aQ7kognlRPDzi")
    expect(gifs["data"]["attributes"]["images"][2]["time"]).to eq(1568700000)
    expect(gifs["data"]["attributes"]["images"][2]["summary"]).to eq("Partly cloudy throughout the day.")
    expect(gifs["data"]["attributes"]["images"][2]["url"]).to eq("https://giphy.com/gifs/beach-clouds-aQ7kognlRPDzi")
    expect(gifs["data"]["attributes"]["images"][3]["time"]).to eq(1568786400)
    expect(gifs["data"]["attributes"]["images"][3]["summary"]).to eq("Partly cloudy throughout the day.")
    expect(gifs["data"]["attributes"]["images"][3]["url"]).to eq("https://giphy.com/gifs/beach-clouds-aQ7kognlRPDzi")
    expect(gifs["data"]["attributes"]["images"][4]["time"]).to eq(1568872800)
    expect(gifs["data"]["attributes"]["images"][4]["summary"]).to eq("Mostly cloudy throughout the day.")
    expect(gifs["data"]["attributes"]["images"][4]["url"]).to eq("https://giphy.com/gifs/dark-castle-63xBFHKNVjZlu")
  end
end

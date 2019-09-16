require "rails_helper"

describe 'Backgrounds API' do
  it "gets an image" do
    json_response = File.open("./fixtures/denver_flickr.json")
    stub_request(:get, "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{ENV['FLICKR_API']}&text=denver,co,skyline&geo_context=2&per_page=1&accuracy=10&format=json").
      to_return(status: 200, body: json_response)
      
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
    image = JSON.parse(response.body)

    expect(image["data"].count).to eq(3)
    expect(image["data"]["attributes"]["image"]["url"]).to eq("https://farm66.staticflickr.com/65535/48628059008_9ab1b6c1ac.jpg")
  end
end

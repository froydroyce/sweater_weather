require "rails_helper"

describe 'Backgrounds API' do
  it "gets an image" do
    json_response = File.open("./fixtures/denver_flickr.json")
    stub_request(:get, "https://www.flickr.com/services/rest/?accuracy=10&api_key=#{ENV['FLICKR_API']}&format=json&geo_context=2&method=flickr.photos.search&nojsoncallback=1&per_page=1&text=denver,co,%20skyline").
      to_return(status: 200, body: json_response)

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
    image = JSON.parse(response.body)

    expect(image["data"].count).to eq(3)
    expect(image["data"]["attributes"]["image"]["url"]).to eq("https://farm1.staticflickr.com/930/43691964192_4ff507454d.jpg")
  end
end

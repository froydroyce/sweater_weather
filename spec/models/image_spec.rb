require "rails_helper"

describe Image do
  it "exists" do
    flickr = File.read("./fixtures/denver_flickr.json")
    response =  JSON.parse(flickr, symbolize_names: true)
    attr = response[:photos][:photo][0]
    image = Image.new(attr)

    expect(image).to be_a Image
    expect(image.url).to eq("https://farm1.staticflickr.com/930/43691964192_4ff507454d.jpg")
  end
end

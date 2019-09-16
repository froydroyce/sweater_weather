require "rails_helper"

describe FlickrService do
  context 'instance methods' do
    it "returns image data" do
      json_response = File.open("./fixtures/denver_flickr.json")
      stub_request(:get, "https://www.flickr.com/services/rest/?accuracy=10&api_key=#{ENV['FLICKR_API']}&format=json&geo_context=2&method=flickr.photos.search&nojsoncallback=1&per_page=1&text=denver,co,%20skyline").
        to_return(status: 200, body: json_response)

      image = subject.image_by('denver,co')

      expect(image).to be_an Hash
      expect(image[:photos][:photo][0].count).to eq(9)
      expect(image[:photos][:photo][0]).to have_key(:id)
      expect(image[:photos][:photo][0]).to have_key(:secret)
      expect(image[:photos][:photo][0]).to have_key(:server)
      expect(image[:photos][:photo][0]).to have_key(:farm)
      expect(image[:photos][:photo][0]).to have_key(:farm)
    end
  end
end

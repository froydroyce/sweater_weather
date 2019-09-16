require "rails_helper"

describe GiphyService do
  context 'instance methods' do
    it "returns image data by summary" do
      mostly_response = File.open("./fixtures/mostly_cloudy.json")
      stub_request(:get, "https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_KEY']}&limit=1&q=Mostly%20cloudy%20throughout%20the%20day.").
        to_return(status: 200, body: mostly_response)
      giphy = subject.gifs_by("Mostly cloudy throughout the day.")

      expect(giphy).to be_a Hash
      expect(giphy.first).to be_a Array
      expect(giphy[:data][0].count).to eq(19)
      expect(giphy[:data][0]).to have_key(:url)
    end
  end
end

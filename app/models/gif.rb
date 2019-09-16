class Gif
  def initialize(time, summary, image)
    @time = time
    @summary = summary
    @url = image["data"][0]["url"]
  end
end

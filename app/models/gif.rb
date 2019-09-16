class Gif
  def initialize(time, summary, image)
    @time = time
    @summary = summary
    @image = image["data"][0]["url"]
  end
end

class Image
  attr_reader :url

  def initialize(attr)
    @url = farm_url(attr)
  end

  def farm_url(attr)
    farm = attr[:farm]
    server = attr[:server]
    id = attr[:id]
    secret = attr[:secret]
    "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}.jpg"
  end
end

class BackgroundsFacade
  attr_reader :id

  def initialize(city_state)
    @city_state = city_state
  end

  def image
    Image.new(image_for(@city_state)[:photos][:photo][0])
  end

  private

  def image_for(city_state)
    @_image_for ||= flickr_service.image_by(city_state)
  end

  def flickr_service
    FlickrService.new
  end
end

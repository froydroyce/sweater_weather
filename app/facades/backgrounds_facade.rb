class BackgroundsFacade
  attr_reader :id

  def initialize(city_state)
    @id = nil
    @city_state = city_state
  end

  def image
    Image.new(image_for(@city_state)[:photos][:photo][0])
  end

  private

  def image_for(city_state)
    flickr_service.image_by(city_state)
  end

  def flickr_service
    @_flickr_service ||= FlickrService.new
  end
end

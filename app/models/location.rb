class Location
  attr_reader :lat, :lng, :city, :state, :country

  def initialize(attr)
    @city = attr[:address_components][0][:long_name]
    @state = attr[:address_components][2][:short_name]
    @country = attr[:address_components][3][:long_name]
    @lat = attr[:geometry][:location][:lat]
    @lng = attr[:geometry][:location][:lng]
  end
end

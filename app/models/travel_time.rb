class TravelTime
  attr_reader :duration
  
  def initialize(attr)
    @duration = attr[:routes][0][:legs][0][:duration]
  end
end

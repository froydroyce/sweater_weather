class DirectionsService
  def directions_by(origin, destination)
    get_json("/api/directions/json?origin=#{origin}&destination=#{destination}")
  end

  private

  def conn
    Faraday.new(url: "https://maps.googleapis.com") do |f|
      f.params['key'] = ENV['GOOGLE_KEY']
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end

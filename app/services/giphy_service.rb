class GiphyService
  def gifs_by(summary)
    get_json("/v1/gifs/search?q=#{summary}")
  end

  private

  def conn
    Faraday.new(url: "https://api.giphy.com") do |f|
      f.params['api_key'] = ENV['GIPHY_KEY']
      f.params['limit'] = 1
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_name: true)
  end
end

class GiphyService
  BASE_URL = "https://api.giphy.com/v1/gifs/search"

  def initialize(api_key)
    @api_key = api_key
  end

  def search_gifs(keyword, limit = 5)
    response = Faraday.get(BASE_URL) do |req|
      req.params["api_key"] = @api_key
      req.params["q"] = keyword
      req.params["limit"] = limit
      req.params["rating"] = "g"
    end

    if response.success?
      JSON.parse(response.body)["data"]
    else
      Rails.logger.error("Giphy API Error: #{response.status} - #{response.body}")
      []
    end
  end
end

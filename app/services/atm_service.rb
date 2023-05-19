class AtmService
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.tomtom.com')
  end

  def self.nearby_atms(lon, lat)
    get_url("/search/2/nearbySearch/.json?key=hYGMeLowXk66FPfBRHUXAW5nLAtfUGNH&lat=#{lat}&lon=#{lon}&limit")
  end
end
class SearchFacade
  def initialize(params)
    @lon = params[:lon]
    @lat = params[:lat]
  end

  def atm_search
    atms = AtmService.nearby_atms(@lon, @lat)
    @atms = []
    atms[:results].each do |atm|
      @atms << Atm.new(atm)
    end
  end
end
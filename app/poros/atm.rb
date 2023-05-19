class Atm
  attr_reader :id,
              :name,
              :address,
              :lat,
              :lon,
              :distance

  def initialize(info)
    @id = info[:id]
    @type = info[:type]
    @attributes = get_attributes(info)
  end

  def get_attributes(info)
    @name = info[:poi][:name]
    @lat = info[:viewport][:topLeftPoint][:lat]
    @lon = info[:viewport][:topLeftPoint][:lon]
    @address = build_address(info[:address])
    @distance = info[:dist]
    { name: "#{@name}", lat: "#{@lat}", lon: "#{@lon}", address: "#{@address}", distance: "#{@distance}"}
  end

  def build_address(info)
    "#{info[:streetNumber]} #{info[:streetName]}, #{info[:countrySecondarySubdivision]}, #{info[:countrySubdivisionName]} #{info[:postalCode]}"
  end
end
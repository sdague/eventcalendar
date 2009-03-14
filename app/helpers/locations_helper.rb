module LocationsHelper
    def create_map(location)
        map = GoogleMap.new(
                            :type => "G_HYBRID_MAP",
                            :zoom => 16
                            )
        
        map.markers << GoogleMapMarker.new(
                                           :map => map,
                                           :lat => location.lat,
                                           :lng => location.lng,
                                           :html => "<b>#{location.name}</b><br/>#{location.address.gsub(/\n/,"<br/>")}<br/><a href='http://maps.google.com/maps?f=d&hl=en&daddr=#{location.lat},#{location.lng}'>Get Directions</a>"
                                           )
        return map
    end
end

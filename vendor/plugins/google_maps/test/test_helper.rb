ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require 'test/unit'
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))

def marker_factory(options = {})
  params = {:map => @map, :lat => 40, :lng => -100, :html => 'Test Marker'}.merge(options)
  GoogleMapMarker.new(params)
end



# frozen_string_literal: true

class Station
  attr_accessor :name
  attr_reader :crs

  def initialize(crs, name = '')
    @name = name
    @crs = crs.upcase
  end

  def self.from_location(location)
    new(location[:crs], location[:location_name])
  end

  def arrivals(from: nil)
    LDBWS.new.arrivals(crs, from_crs: from)
  end

  def departures(to: nil)
    LDBWS.new.departures(crs, destination_crs: to)
  end

  def to_s
    return "#{name} (#{crs})" unless name.blank?
    crs
  end
end

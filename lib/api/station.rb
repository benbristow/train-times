# frozen_string_literal: true

class Station
  attr_accessor :name
  attr_reader :code

  def initialize(code, name = '')
    @name = name
    @code = code.upcase
  end

  def self.from_location(location)
    new(location[:crs], location[:location_name])
  end

  def arrivals(from:)
    LDBWS.new.arrivals(code, from_crs: from)
  end

  def departures(to:)
    LDBWS.new.departures(code, destination_crs: to)
  end

  def to_s
    return "#{name} (#{code})" unless name.blank?
    code
  end
end

#!/usr/bin/env ruby
# frozen_string_literal: true

Dir.chdir(__dir__)

require 'rubygems'
require 'bundler'
Bundler.require(:default)
Dotenv.load

require_all 'lib'

Clamp do
  parameter 'ORIGIN/ARRIVAL', 'Departures: Starting station / Arrivals: Station arriving at', attribute_name: :primary_crs
  parameter '[DESTINATION/FROM]', 'Departures: Destination station / Arrivals: Station train arriving from', attribute_name: :secondary_crs
  option ['-a', '--arrivals'], :flag, 'Show arrivals instead of departures?'

  def execute
    @primary_station = Station.new(primary_crs)
    puts @primary_station.departures(to: (secondary_crs || '').upcase) unless arrivals?
    puts @primary_station.arrivals(from: (secondary_crs || '').upcase) if arrivals?
  rescue TrainTimesError => error
    puts "Error: #{error.message}"
  rescue Savon::SOAPFault
    puts 'Error: Server error - You probably put in an invalid station code'
  end
end

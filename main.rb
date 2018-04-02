#!/usr/bin/env ruby
# frozen_string_literal: true

Dir.chdir(__dir__)

require 'rubygems'
require 'bundler'
Bundler.require(:default)
Dotenv.load

require_all 'lib'

Clamp do
  subcommand 'arrivals', 'Get arrivals for a station' do
    parameter 'Arriving', 'Station trains are arriving at', attribute_name: :arriving
    parameter '[From]', 'Station trains are arriving from', attribute_name: :from

    def execute
      with_error_handling do
        puts ServiceTable.new(station_board(arriving, from, 'arrivals')).to_s
      end
    end
  end

  subcommand 'departures', 'Get departures for a station' do
    parameter 'Departing', 'Station trains are departing from', attribute_name: :departing
    parameter '[To]', 'Station trains are travelling to', attribute_name: :to

    def execute
      with_error_handling do
        puts ServiceTable.new(station_board(departing, to, 'departures')).to_s
      end
    end
  end

  subcommand 'details', 'Get detailsrmation for a specific service' do
    parameter 'Service ID', 'Service ID of the train service', attribute_name: :service_id

    def execute
      with_error_handling do
        service = Service.from_service_id(service_id)
        puts CallingPointTable.new(service.timetable.calling_points).to_s
      end
    end
  end

  private

  def with_error_handling
    yield
  rescue TrainTimesError => error
    puts "Error: #{error.message}"
  rescue Savon::SOAPFault
    puts 'Error: Request error. You probably inputted something wrong'
  rescue SocketError
    puts 'Unable to connect to National Rail API. Perhaps there is an issue with your internet connection?'
  rescue Exception => error
    puts "Unknown error: #{error}"
  end

  def station_board(primary_crs, secondary_crs, mode)
    @primary_station = Station.new(primary_crs)

    return @primary_station.arrivals(from: (secondary_crs || '').upcase) if mode == 'arrivals'
    return @primary_station.departures(to: (secondary_crs || '').upcase) if mode == 'departures'
  end
end

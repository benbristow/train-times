#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.require(:default)
Dotenv.load

require_all 'lib'

Clamp do
  parameter 'ORIGIN', 'Origin Station', attribute_name: :origin
  parameter 'DESTINATION/FROM', 'Destination station (Departures) or From Station (Arrivals)', attribute_name: :secondary

  option ['-m', '--mode'], 'Mode', 'departures/arrivals', default: 'departures' do |answer|
    answer == 'arrivals' ? 'arrivals' : 'departures'
  end

  def execute
    @origin_station = Station.new(origin)
    puts @origin_station.departures(to: secondary) unless mode == 'arrivals'
    puts @origin_station.arrivals(from: secondary) if mode == 'arrivals'
  end
end

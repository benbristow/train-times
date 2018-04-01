# frozen_string_literal: true

class Service
  attr_reader :id
  attr_reader :mode
  attr_reader :time
  attr_reader :estimated
  attr_reader :origin
  attr_reader :destination
  attr_reader :platform
  attr_reader :operator
  attr_reader :transport_method
  attr_reader :timetable

  def initialize(info)
    @timetable = Timetable.new(info)

    @id = info[:service_id]
    @mode = info[:std].nil? ? 'arrival' : 'departure'
    @time = info[:std] || info[:sta]
    @origin = parse_origin(info)
    @destination = parse_destination(info)
    @estimated = parse_estimated(info)
    @platform = info[:platform] || 'N/S'
    @operator = info[:operator]
    @transport_method = info[:service_type]
  end

  def self.from_service_id(service_id)
    LDBWS.new.service_details(service_id)
  end

  private

  def parse_estimated(info)
    return @timetable.calling_points.last.estimated if @timetable.calling_points.any?
    info[:etd] || info[:eta]
  end

  def parse_origin(info)
    return Station.from_location(info[:origin][:location]) if info[:origin]
    return @timetable.calling_points.first.station if @timetable.calling_points.any?
  end

  def parse_destination(info)
    return Station.from_location(info[:destination][:location]) if info[:destination]
    return @timetable.calling_points.last.station if @timetable.calling_points.any?
  end
end

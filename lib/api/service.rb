# frozen_string_literal: true

class Service
  attr_reader :id, :mode, :time, :estimated, :origin, :destination, :platform, :operator, :transport_method, :timetable

  OPERATORS_MAPPING = {
    'Chiltern Railways' => 'Chiltern',
    'East Midlands Trains' => 'EMT',
    'Great Western Railway' => 'GWR',
    'London North Eastern Railway' => 'LNER',
    'TransPennine Express' => 'TPE',
    'Transport for Wales' => 'TfW',
    'West Midlands Trains' => 'WMT',
    'Virgin Trains' => 'Virgin'
  }.freeze

  def initialize(info)
    @timetable = Timetable.new(info)

    @id = info[:service_id]
    @mode = info[:std].nil? ? 'arrival' : 'departure'
    @time = info[:std] || info[:sta]
    @origin = parse_origin(info)
    @destination = parse_destination(info)
    @estimated = parse_estimated(info)
    @platform = info[:platform] || '--'
    @operator = OPERATORS_MAPPING[info[:operator]] || info[:operator]
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

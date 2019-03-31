# frozen_string_literal: true
require_relative 'table'

class ServiceTable < Table
  TABLE_MAPPING = {
    'Time' => 'time',
    'Operator' => 'operator',
    'Estimated' => 'estimated',
    'Plat.' => 'platform',
    'Origin' => 'origin',
    'Destination' => 'destination',
    'ID' => 'id'
  }.freeze

  def initialize(services)
    services = [] if services.nil?
    services = [services] unless services.is_a?(Array)
    super(services, TABLE_MAPPING)
  end
end

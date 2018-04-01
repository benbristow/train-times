# frozen_string_literal: true

class ServiceTable < Table
  TABLE_MAPPING = {
    'Time' => 'time',
    'Estimated' => 'estimated',
    'Plat.' => 'platform',
    'Origin' => 'origin',
    'Destination' => 'destination',
    'ID' => 'id'
  }.freeze

  def initialize(services)
    services = [services] unless services.is_a?(Array)
    super(services, TABLE_MAPPING)
  end
end

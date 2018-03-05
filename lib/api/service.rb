# frozen_string_literal: true

class Service
  attr_reader :id
  attr_reader :mode
  attr_reader :time
  attr_reader :status
  attr_reader :origin
  attr_reader :destination
  attr_reader :platform
  attr_reader :operator
  attr_reader :transport_method

  def initialize(info)
    @id = info[:service_id]
    @mode = info[:std].nil? ? 'arrival' : 'departure'
    @time = info[:std] || info[:sta]
    @status = info[:etd] || info[:eta]
    @origin = Station.from_location(info[:origin][:location])
    @destination = Station.from_location(info[:destination][:location])
    @platform = info[:platform] || 'N/S'
    @operator = info[:operator]
    @transport_method = info[:service_type]
  end

  def on_time?
    status == 'On time'
  end
end

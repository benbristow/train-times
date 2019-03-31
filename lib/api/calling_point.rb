# frozen_string_literal: true

class CallingPoint
  attr_accessor :station, :estimated, :scheduled

  def initialize(info)
    @station = Station.from_location(info)
    @scheduled = info[:st] || info[:sta]
    @estimated = parse_estimated(info)
  end

  private

  def parse_estimated(info)
    estimated_value = info[:et] || info[:eta] || 'N/A'
    estimated_value.casecmp('on time').zero? ? @scheduled : estimated_value
  end
end

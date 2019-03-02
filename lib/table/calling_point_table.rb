# frozen_string_literal: true
require_relative 'table'

class CallingPointTable < Table
  TABLE_MAPPING = {
    'Station' => 'station',
    'Scheduled' => 'scheduled',
    'Estimated' => 'estimated'
  }.freeze

  def initialize(calling_points)
    super(calling_points, TABLE_MAPPING)
  end
end

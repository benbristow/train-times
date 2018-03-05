# frozen_string_literal: true

class Table
  TABLE_MAPPING = {
    'Time' => 'time',
    'Estimated' => 'estimated',
    'Plat.' => 'platform',
    'Origin' => 'origin',
    'Destination' => 'destination'
  }.freeze

  def initialize(services)
    @services = services
  end

  def to_s
    Terminal::Table.new(headings: headings, rows: rows).to_s
  end

  private

  def headings
    TABLE_MAPPING.keys
  end

  def rows
    @services.map do |service|
      TABLE_MAPPING.values.map { |key| service.send(key) }
    end
  end
end

# frozen_string_literal: true

class Table
  SERVICE_KEYS = %w[time estimated platform origin destination].freeze

  def initialize(services)
    @services = services
  end

  def to_s
    Terminal::Table.new(headings: headings, rows: rows).to_s
  end

  private

  def headings
    SERVICE_KEYS.map(&:capitalize)
  end

  def rows
    @services.map do |service|
      SERVICE_KEYS.map { |key| service.send(key) }
    end
  end
end

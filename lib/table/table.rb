# frozen_string_literal: true

class Table
  def initialize(objects, mapping)
    @objects = objects
    @mapping = mapping
  end

  def to_s
    Terminal::Table.new(headings: headings, rows: rows).to_s
  end

  private

  def headings
    @mapping.keys
  end

  def rows
    @objects.map do |object|
      @mapping.values.map { |key| object.send(key) }
    end
  end
end

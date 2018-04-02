# frozen_string_literal: true

class Timetable
  attr_reader :calling_points

  def initialize(info)
    @calling_points = parse_calling_points(info)
  end

  private

  def parse_calling_points(info)
    calling_points = []
    calling_points << info[:previous_calling_points][:calling_point_list][:calling_point] if info[:previous_calling_points]
    calling_points << info if calling_points.any?
    calling_points << info[:subsequent_calling_points][:calling_point_list][:calling_point] if info[:subsequent_calling_points]
    calling_points.flatten.map { |calling_point| CallingPoint.new(calling_point) }
  end
end

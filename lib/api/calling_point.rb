class CallingPoint
  attr_accessor :station
  attr_accessor :estimated
  attr_accessor :scheduled

  def initialize(info)
    @station = Station.from_location(info)
    @estimated = info[:at] || info[:eta]
    @scheduled = info[:st] || info[:sta]
  end
end

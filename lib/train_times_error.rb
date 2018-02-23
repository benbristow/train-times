# frozen_string_literal: true

class TrainTimesError < StandardError
  def initialize(message = 'Script error')
    super(message)
  end
end

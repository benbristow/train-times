# frozen_string_literal: true

RSpec.describe Service do
  describe '#mode' do
    it 'detects it is an arrival from params' do
      expect(arrival.mode).to eq('arrival')
    end

    it 'detects it is a departure from params' do
      expect(departure.mode).to eq('departure')
    end
  end

  describe '#platform' do
    it 'displays platform when assigned' do
      expect(arrival(platform: 1).platform).to eq(1)
    end

    it 'displays -- (not assigned) when no platform assigned' do
      expect(arrival(platform: nil).platform).to eq('--')
    end
  end

  private

  def arrival(params = {})
    Service.new(service_params({ sta: '14:20', eta: 'On time' }.merge(params)))
  end

  def departure(params = {})
    Service.new(service_params({ std: '14:20', etd: 'On time' }.merge(params)))
  end

  def service_params(params = {})
    {
      platform: '4R',
      operator: 'ScotRail',
      operator_crs: 'SR',
      service_type: 'train',
      service_id: '1EInFILNb5BWvxnAIhAmCg==',
      rsid: 'SR595100',
      origin: {
        location: {
          location_name: 'Glasgow Central',
          crs: 'GLC'
        }
      },
      destination: {
        location: {
          location_name: 'Lanark',
          crs: 'LNK',
          via: 'via Bellshill & Shieldmuir'
        }
      }
    }.merge(params)
  end
end

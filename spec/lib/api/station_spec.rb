# frozen_string_literal: true

RSpec.describe Station do
  it 'can be created with just a station crs' do
    station = Station.new('glc')

    expect(station.crs).to eq('GLC')
    expect(station.name).to eq('')
  end

  it 'can be created with a station crs and a name' do
    station = Station.new('glc', 'Glasgow Central')

    expect(station.crs).to eq('GLC')
    expect(station.name).to eq('Glasgow Central')
  end

  it 'can get departures' do
    VCR.use_cassette('departures') do
      station = Station.new('glc', 'Glasgow Central')
      departures = station.departures

      expect(departures).not_to be_empty
      expect(departures.first.class).to eq(Service)
      expect(departures.first.operator).to eq('ScotRail')
    end
  end

  it 'can get arrivals' do
    VCR.use_cassette('arrivals') do
      station = Station.new('glc', 'Glasgow Central')
      departures = station.arrivals

      expect(departures).not_to be_empty
      expect(departures.first.class).to eq(Service)
      expect(departures.first.mode).to eq('arrival')
      expect(departures.first.operator).to eq('ScotRail')
    end
  end

  context '#to_s' do
    it 'outputs just station crs when has no name specified' do
      station = Station.new('glc')

      expect(station.to_s).to eq('GLC')
    end

    it 'outputs both station crs and name when available' do
      station = Station.new('glc', 'Glasgow Central')

      expect(station.to_s).to eq('Glasgow Central (GLC)')
    end
  end
end

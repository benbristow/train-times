# frozen_string_literal: true

class LDBWS
  ENDPOINT_URL = 'https://lite.realtime.nationalrail.co.uk/OpenLDBWS/ldb11.asmx'
  WSDL_URL = 'https://lite.realtime.nationalrail.co.uk/OpenLDBWS/rtti_2017-10-01_ldb.wsdl'
  NS1_NAMESPACE = 'http://thalesgroup.com/RTTI/2014-02-20/ldb/'
  NS2_NAMESPACE = 'http://thalesgroup.com/RTTI/2010-11-01/ldb/commontypes'

  def arrivals(at_crs, from_crs: nil)
    response = client.call(:get_arrival_board, message: request_body(at_crs, from_crs, 'arrivals'))
    extract_services(response.body[:get_arrival_board_response])
  end

  def departures(origin_crs, destination_crs: nil)
    response = client.call(:get_departure_board, message: request_body(origin_crs, destination_crs, 'departures'))
    extract_services(response.body[:get_departure_board_response])
  end

  private

  def extract_services(board_response)
    raise TrainTimesError.new('No train times found') if board_response[:get_station_board_result][:train_services].nil?
    services = board_response[:get_station_board_result][:train_services][:service]
    services.map { |service| Service.new(service) }
  rescue TypeError # quick hack - when only one service object seems to return differently
    Service.new(services)
  end

  def request_body(a, b, mode)
    {
      numRows: 15,
      crs: a,
      filterCrs: b,
      filterType: mode == 'arrivals' ? 'from' : 'to',
      timeOffset: nil,
      timeWindow: nil
    }
  end

  def client
    Savon.client(
      wsdl: WSDL_URL,
      endpoint: ENDPOINT_URL,
      soap_header: {
        'ns2:AccessToken' => {
          'ns2:TokenValue' => access_token
        }
      },
      namespaces: {
        'xmlns:ns1' => NS1_NAMESPACE,
        'xmlns:ns2' => NS2_NAMESPACE
      }
    )
  end

  def access_token
    raise TrainTimesError.new('No national rail access token provided') unless ENV['NATIONAL_RAIL_TOKEN']
    ENV['NATIONAL_RAIL_TOKEN']
  end
end

require 'one_to_one'
require 'spec_helper'

describe OneToOne::UserService do
  let(:user) { Savon::Client.new "http://localhost:9999/svbase4api/UserService?WSDL" }

  describe 'mocks the PING SOAP request' do
    before do
      ping_method = savon
      ping_method.expects('Ping').with do |request|
        request.soap.body.should include('credential')
        request.soap.body['credential'].should include('clientName' => OneToOne::UserService::CLIENTNAME,
                                                       'userName'   => OneToOne::UserService::USERNAME,
                                                       'password'   => OneToOne::UserService::PASSWORD)
      end
      ping_method.returns(:user_ping)
    end

    it 'pings the API service' do
      OneToOne::UserService.ping_service.should be_a(DateTime)
    end

    it 'provides information of the api being active' do
      OneToOne::UserService.api_active?.should == true
    end
  end
end

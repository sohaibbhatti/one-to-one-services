require 'one_to_one'
require 'spec_helper'

#ssh -L 9999:65.182.173.79:8080 deploy@testing2.moviepass.com

describe OneToOne::Request::UserService do
  let(:user) { Savon::Client.new "http://localhost:9999/svbase4api/UserService?WSDL" }

  describe 'mocks the Ping SOAP request' do
    before do
      ping_method = savon
      ping_method.expects('Ping').with do |request|
        contains_credentials request
      end
      ping_method.returns(:user_ping)
    end

    it 'pings the API service' do
      OneToOne::Request::UserService.ping_service.should be_a(DateTime)
    end

    it 'provides information of the api being active' do
      OneToOne::Request::UserService.api_active?.should == true
    end
  end
end

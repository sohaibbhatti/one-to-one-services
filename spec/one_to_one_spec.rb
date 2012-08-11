require 'one_to_one'
require 'spec_helper'

#ssh -L 9999:65.182.173.79:8080 deploy@testing2.moviepass.com

describe OneToOne::UserService do
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
      OneToOne::UserService.ping_service.should be_a(DateTime)
    end

    it 'provides information of the api being active' do
      OneToOne::UserService.api_active?.should == true
    end
  end
end

describe OneToOne::CardService do
  let(:card) { Savon::Client.new "http://localhost:9999/svbase4api/CardService?WSDL" }

  describe 'mocks the BlockCard SOAP request' do
    before do
      block_method = savon
      block_method.expects('BlockCard').with do |request|
        contains_credentials request

        request.soap.body.should include('cardId')
        request.soap.body['cardId'].should == '12345'
      end
    end

    it 'blocks a card via API service' do
      result = OneToOne::CardService.block_card '12345'
      result.should == true
    end
  end

  describe 'mocks the ActivateCard SOAP request' do
    before do
      block_method = savon
      block_method.expects('ActivateCard').with do |request|
        contains_credentials request

        request.soap.body.should include('cardId')
        request.soap.body['cardId'].should == '12345'
      end
    end

    it 'activates a card via API service' do
      result = OneToOne::CardService.activate_card '12345'
      result.should == true
    end
  end
end

require 'one_to_one'
require 'spec_helper'

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

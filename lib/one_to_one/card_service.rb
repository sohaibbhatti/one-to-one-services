require 'savon'
require 'one_to_one/request/base'

module OneToOne
  class CardService < Request::Base
    class << self

      def block_card(card_key)
        client = load_wsdl :card
        response = client.request :car, 'BlockCard',
          :body => {
          'credential' => credentials,
          'cardId' => card_key
        }
        response.success?
      end

      def activate_card(card_key)
        client = load_wsdl :card
        response = client.request :car, 'ActivateCard',
          :body => {
          'credential' => credentials,
          'cardId' => card_key
        }
        response.success?
      end

      def credentials
        { 'clientName' => CLIENTNAME, 'userName' => USERNAME, 'password' => PASSWORD }
      end


    end
  end
end

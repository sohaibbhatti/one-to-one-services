require 'savon'
require 'one_to_one/request/base'

module OneToOne
  module Request
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

        # add check for card status
        def change_card_status(card_key, status, reason = nil)
          client = load_wsdl :card
          response = client.request :car, 'ChangeCardStatus',
            :body => {
            'credential' => credentials,
            'cardId' => card_key,
            'cardStatus' => status,
            'cardStatusReason' => reason
          }
        end

        def get_card_status(card_key)
          client = load_wsdl :card
          response = client.request :car, 'GetCardStatus',
            :body => {
            'credential' => credentials,
            'cardId' => card_key
          }
        end

        def credentials
          { 'clientName' => CLIENTNAME, 'userName' => USERNAME, 'password' => PASSWORD }
        end

      end

    end
  end
end

require 'savon'
require 'one_to_one/request/base'
module OneToOne
  class UserService < Request::Base
    class << self

      def ping_service
        client = load_wsdl :user
        response = client.request :user, 'Ping', :body => { 'credential' => credentials }
        response.to_hash[:ping_response][:ping_response]
      end

      def api_active?
        ping_service.is_a? DateTime
      end

      # Used to create a user and his corresponding card and account.
      # activation_answer is a numberic (non unique) number that can be upto 8 digits
      # and is used for verification by the end user for activating the card
      # TODO: Add Check to see if all information are hashs
      # TODO: Add Check to see if address_data and shipping_data hash are the same or not
      def create_user(card_data, people_data, address_data, load_amount=0, shipping_data=nil)
        client = load_wsdl :order
        response = client.request :ord, 'PlacePersonalizedOrder',
          :body => {
          'credential' => credentials,
          'personalizedOrder' => {
            'programName' => PROGRAMNAME,
            'orderItems' => {
              'initialLoadAmount' => load_amount,
              'carddata' => card_data,
              'people' => people_data,
              'shipmentAddress' => (shipping_data.nil? ? address_data : shipping_data)
            }
          }
        }
        return response[:place_personalized_order_response][:personalized_order_result] if response.success?
      end

      def card_data_hash(first_name, last_name, activation_label, activation_answer)
        { 'name3' => first_name,
          'name4' => last_name,
          'activationLabel' => activation_label,
          'activationAnswer' => activation_answer }
      end

      def people_hash(email, last_name, first_name, address)
        address = user.addresses.first
        { 'email' => email,
          'lastName' => last_name,
          'firstName' => first_name,
          'address' => address_hash(user) }
      end

      # NOTE: Should it be shipping or billing address?
      def address_hash(street, city, country, zip, state) 
        address = user.addresses.first
        { 'streetLines' => street,
          'city' => city,
          'country' => country,
          'zip' => zip,
          'state' => state }
      end

      def credentials
        { 'clientName' => CLIENTNAME, 'userName' => USERNAME, 'password' => PASSWORD }
      end
    end
  end
end

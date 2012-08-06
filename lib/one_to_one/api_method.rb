require 'savon'

module OneToOne
  class ApiMethod

    class << self

      def ping_service
        client = load_wsdl :user
        response = client.request :user, 'Ping', :body => { 'credential' => credentials }
        response.to_hash[:ping_response][:ping_response]
      end

      def api_active?
        ping_service.is_a? DateTime
      end

      def load_wsdl (wsdl_name = :user)
        raise 'Invalid wsdl name provided' unless [:user, :card, :account, :order].include? wsdl_name
        base_wsdl_url = "http://localhost:9999/svbase4api/#{wsdl_name.to_s.capitalize}Service?WSDL"
        Savon::Client.new(base_wsdl_url)
      end

      def credentials
        { 'clientName' => CLIENTNAME, 'userName' => USERNAME, 'password' => PASSWORD }
      end
    end
  end
end

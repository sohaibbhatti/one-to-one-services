module OneToOne
  module Request
    class Base

      class << self
        def load_wsdl (wsdl_name = :user)
          raise 'Invalid wsdl name provided' unless [:user, :card, :account, :order].include? wsdl_name
          base_wsdl_url = "http://localhost:9999/svbase4api/#{wsdl_name.to_s.capitalize}Service?WSDL"
          Savon::Client.new(base_wsdl_url)
        end
      end

    end
  end
end

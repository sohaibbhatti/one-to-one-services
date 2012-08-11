require 'savon_spec'


Savon::Spec::Fixture.path = File.expand_path("../fixtures", __FILE__)

# Adding dummy Testing credentials. 1to1 needs to be contacted for the actual development creds.
OneToOne::UserService.class_eval do
  CLIENTNAME = 'TESTCLIENT'
  USERNAME = 'TESTUSER'
  PASSWORD = 'TESTPASSWORD'
end


Rspec.configure do |config|
  config.include Savon::Spec::Macros
end

def contains_credentials(request)
  request.soap.body.should include('credential')
  request.soap.body['credential'].should include('clientName' => OneToOne::UserService::CLIENTNAME,
                                                 'userName'   => OneToOne::UserService::USERNAME,
                                                 'password'   => OneToOne::UserService::PASSWORD)
end

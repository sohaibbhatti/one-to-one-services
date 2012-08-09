require 'savon_spec'


Savon::Spec::Fixture.path = File.expand_path("../fixtures", __FILE__)

OneToOne::UserService.class_eval do
  CLIENTNAME = 'TESTCLIENT'
  USERNAME = 'TESTUSER'
  PASSWORD = 'TESTPASSWORD'
end


Rspec.configure do |config|
  config.include Savon::Spec::Macros

end

require 'one_to_one'

describe OneToOne::UserService do
  it 'Pings the service' do
    OneToOne::UserService.ping_service.should be_a(DateTime)
  end

  it 'Validates API is active' do
    OneToOne::UserService.api_active?.should == true
  end
end

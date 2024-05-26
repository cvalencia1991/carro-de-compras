require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(id: 1,
                        name: 'cesar',
                        email: 'cesar4a6z@gmail.com',
                        jti: '48784244-a04d-45fc-a27e-839b552ac9ae',
                        password: 'password',
                        password_confirmation: 'password')
  end
  it 'Auction is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'Auction is not valid with the email empty' do
    subject.email = nil
    expect(subject).not_to be_valid
  end
  it "Auction is not valid with the 'password' empty" do
    subject.password = nil
    expect(subject).not_to be_valid
  end
end

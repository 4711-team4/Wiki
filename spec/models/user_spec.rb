require 'rails_helper'

RSpec.describe User, type: :model do
  let(:email) { "test@example.com" }
  let(:warden_conditions) {{ login: email  }}
  let(:warden_conditions2) {{ username: "test"}}

  it "finds user by email" do
    user = User.create(email: email, username:"test", password:"Asdf4321$")
    authenticated= User.find_for_database_authentication(warden_conditions)
    expect(authenticated).to eql user
    user.delete
  end

  it "finds user by username" do
    user = User.create(username: "test", email: "testt@example.com", password:"Asdf4321$")
    authenticated = User.find_for_database_authentication(warden_conditions2)
    expect(authenticated).to eql user
    user.delete
  end
end

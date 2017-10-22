require 'rails_helper'

RSpec.describe User, type: :model do
  context "#user" do
    it { should have_valid(:username).when('Azathoth', 'num112358') }
    it { should_not have_valid(:username).when(nil, '', 'bob', 'iamthegreatandterribleozwhoareyou', '$ymbols') }

    it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
    it { should_not have_valid(:email).when(nil, '', 'urser', 'usersr@com', 'usersba.com') }

    it 'has requires a unique username' do
      original = FactoryGirl.create(:user)
      user = User.new
      user.username = original.username
      user.password = 'password'
      user.password_confirmation = 'password'

      expect(user).to_not be_valid
      expect(user.errors[:username]).to_not be_blank
    end
  end

  context "#associations" do
    # it { should have_many : }
    # it { should have_many : }
  end
end

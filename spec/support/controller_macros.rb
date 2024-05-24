module ControllerMacros
    def login_user
      # Before each test, create and login the user
      before(:each) do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        api_v1_sign_in FactoryBot.create(:user)
      end
    end
  end
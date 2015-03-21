module ControllerSpecsHelper
  def login_admin
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    admin = FactoryGirl.create(:admin)
    # admin.confirm!
    sign_in :user, admin
    admin
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      # user.confirm!
      sign_in user
      @user = user
    end
  end
end
module RequestSpecsHelper
  def manual_sign_in
    u = User.create :email => 'test@test.com', :password => 'carltonlasiter'
    visit 'users/sign_in'
    fill_in 'Email', with: u.email
    fill_in 'Password', with: 'carltonlasiter'
    click_button 'Log in'
    u
  end
end

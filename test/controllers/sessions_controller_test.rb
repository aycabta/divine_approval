require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get session on login' do
    ldap_user = Fabricate(:great_user)
    post(login_path, params: { username: ldap_user.uid, password: ldap_user.userPassword })
    assert_response(:found)
    assert_not_nil(assigns(:user))
    assert_equal('logged in', flash[:login_alert])
  end

  test 'should fail to get session on login with invalid password' do
    ldap_user = Fabricate(:great_user)
    post(login_path, params: { username: ldap_user.uid, password: '' })
    assert_response(:found)
    assert_redirected_to(root_path)
    assert_nil(assigns(:user))
    assert_equal('username or password is wrong', flash[:login_alert])
  end

  test 'should destroy session' do
    ldap_user = Fabricate(:great_user)
    post(login_path, params: { username: ldap_user.uid, password: ldap_user.userPassword })
    assert_response(:found)
    assert_not_nil(assigns(:user))
    post(logout_path)
    assert_response(:found)
    assert_redirected_to(root_path)
    assert_nil(assigns(:user))
  end
end

require 'test_helper'

class Admin::HomeControllerTest < ActionController::TestCase

  test "#index" do
    get :index
    assert_response :unauthorized

    # with user session
    get :index, session: { auth_session: 'admin' }
    assert_response :success
  end

  test "#logout" do
    get :logout, session: { auth_session: 'admin' }
    assert_response :redirect
    assert_equal(session[:auth_session], 'logged_out')
  end

end

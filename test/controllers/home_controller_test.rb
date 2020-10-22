require 'test_helper'
require 'helpers/application_controller_test_helper'

class HomeControllerTest < ApplicationControllerTest
  active_tab :index

  test '#index' do
    get :index

    assert_response :success
    assert_equal(self.active_tab, :index)
  end

end

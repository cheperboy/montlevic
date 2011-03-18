require 'test_helper'

class FacdivsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facdivs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facdiv" do
    assert_difference('Facdiv.count') do
      post :create, :facdiv => { }
    end

    assert_redirected_to facdiv_path(assigns(:facdiv))
  end

  test "should show facdiv" do
    get :show, :id => facdivs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => facdivs(:one).to_param
    assert_response :success
  end

  test "should update facdiv" do
    put :update, :id => facdivs(:one).to_param, :facdiv => { }
    assert_redirected_to facdiv_path(assigns(:facdiv))
  end

  test "should destroy facdiv" do
    assert_difference('Facdiv.count', -1) do
      delete :destroy, :id => facdivs(:one).to_param
    end

    assert_redirected_to facdivs_path
  end
end

require 'test_helper'

class PulvesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pulves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pulve" do
    assert_difference('Pulve.count') do
      post :create, :pulve => { }
    end

    assert_redirected_to pulve_path(assigns(:pulve))
  end

  test "should show pulve" do
    get :show, :id => pulves(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pulves(:one).to_param
    assert_response :success
  end

  test "should update pulve" do
    put :update, :id => pulves(:one).to_param, :pulve => { }
    assert_redirected_to pulve_path(assigns(:pulve))
  end

  test "should destroy pulve" do
    assert_difference('Pulve.count', -1) do
      delete :destroy, :id => pulves(:one).to_param
    end

    assert_redirected_to pulves_path
  end
end

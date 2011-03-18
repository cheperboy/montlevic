require 'test_helper'

class MyusersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:myusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create myuser" do
    assert_difference('Myuser.count') do
      post :create, :myuser => { }
    end

    assert_redirected_to myuser_path(assigns(:myuser))
  end

  test "should show myuser" do
    get :show, :id => myusers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => myusers(:one).to_param
    assert_response :success
  end

  test "should update myuser" do
    put :update, :id => myusers(:one).to_param, :myuser => { }
    assert_redirected_to myuser_path(assigns(:myuser))
  end

  test "should destroy myuser" do
    assert_difference('Myuser.count', -1) do
      delete :destroy, :id => myusers(:one).to_param
    end

    assert_redirected_to myusers_path
  end
end

require 'test_helper'

class LaboursControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:labours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create labour" do
    assert_difference('Labour.count') do
      post :create, :labour => { }
    end

    assert_redirected_to labour_path(assigns(:labour))
  end

  test "should show labour" do
    get :show, :id => labours(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => labours(:one).to_param
    assert_response :success
  end

  test "should update labour" do
    put :update, :id => labours(:one).to_param, :labour => { }
    assert_redirected_to labour_path(assigns(:labour))
  end

  test "should destroy labour" do
    assert_difference('Labour.count', -1) do
      delete :destroy, :id => labours(:one).to_param
    end

    assert_redirected_to labours_path
  end
end

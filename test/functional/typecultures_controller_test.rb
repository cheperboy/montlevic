require 'test_helper'

class TypeculturesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:typecultures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create typeculture" do
    assert_difference('Typeculture.count') do
      post :create, :typeculture => { }
    end

    assert_redirected_to typeculture_path(assigns(:typeculture))
  end

  test "should show typeculture" do
    get :show, :id => typecultures(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => typecultures(:one).to_param
    assert_response :success
  end

  test "should update typeculture" do
    put :update, :id => typecultures(:one).to_param, :typeculture => { }
    assert_redirected_to typeculture_path(assigns(:typeculture))
  end

  test "should destroy typeculture" do
    assert_difference('Typeculture.count', -1) do
      delete :destroy, :id => typecultures(:one).to_param
    end

    assert_redirected_to typecultures_path
  end
end

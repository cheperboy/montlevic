require 'test_helper'

class VerifsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:verifs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create verif" do
    assert_difference('Verif.count') do
      post :create, :verif => { }
    end

    assert_redirected_to verif_path(assigns(:verif))
  end

  test "should show verif" do
    get :show, :id => verifs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => verifs(:one).to_param
    assert_response :success
  end

  test "should update verif" do
    put :update, :id => verifs(:one).to_param, :verif => { }
    assert_redirected_to verif_path(assigns(:verif))
  end

  test "should destroy verif" do
    assert_difference('Verif.count', -1) do
      delete :destroy, :id => verifs(:one).to_param
    end

    assert_redirected_to verifs_path
  end
end

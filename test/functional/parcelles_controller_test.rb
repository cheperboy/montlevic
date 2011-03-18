require 'test_helper'

class ParcellesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parcelles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parcelle" do
    assert_difference('Parcelle.count') do
      post :create, :parcelle => { }
    end

    assert_redirected_to parcelle_path(assigns(:parcelle))
  end

  test "should show parcelle" do
    get :show, :id => parcelles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => parcelles(:one).to_param
    assert_response :success
  end

  test "should update parcelle" do
    put :update, :id => parcelles(:one).to_param, :parcelle => { }
    assert_redirected_to parcelle_path(assigns(:parcelle))
  end

  test "should destroy parcelle" do
    assert_difference('Parcelle.count', -1) do
      delete :destroy, :id => parcelles(:one).to_param
    end

    assert_redirected_to parcelles_path
  end
end

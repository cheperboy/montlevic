require 'test_helper'

class FacturesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:factures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facture" do
    assert_difference('Facture.count') do
      post :create, :facture => { }
    end

    assert_redirected_to facture_path(assigns(:facture))
  end

  test "should show facture" do
    get :show, :id => factures(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => factures(:one).to_param
    assert_response :success
  end

  test "should update facture" do
    put :update, :id => factures(:one).to_param, :facture => { }
    assert_redirected_to facture_path(assigns(:facture))
  end

  test "should destroy facture" do
    assert_difference('Facture.count', -1) do
      delete :destroy, :id => factures(:one).to_param
    end

    assert_redirected_to factures_path
  end
end

require 'test_helper'

class VentesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ventes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vente" do
    assert_difference('Vente.count') do
      post :create, :vente => { }
    end

    assert_redirected_to vente_path(assigns(:vente))
  end

  test "should show vente" do
    get :show, :id => ventes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ventes(:one).to_param
    assert_response :success
  end

  test "should update vente" do
    put :update, :id => ventes(:one).to_param, :vente => { }
    assert_redirected_to vente_path(assigns(:vente))
  end

  test "should destroy vente" do
    assert_difference('Vente.count', -1) do
      delete :destroy, :id => ventes(:one).to_param
    end

    assert_redirected_to ventes_path
  end
end

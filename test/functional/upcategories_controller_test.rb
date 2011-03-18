require 'test_helper'

class UpcategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:upcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create upcategory" do
    assert_difference('Upcategory.count') do
      post :create, :upcategory => { }
    end

    assert_redirected_to upcategory_path(assigns(:upcategory))
  end

  test "should show upcategory" do
    get :show, :id => upcategories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => upcategories(:one).to_param
    assert_response :success
  end

  test "should update upcategory" do
    put :update, :id => upcategories(:one).to_param, :upcategory => { }
    assert_redirected_to upcategory_path(assigns(:upcategory))
  end

  test "should destroy upcategory" do
    assert_difference('Upcategory.count', -1) do
      delete :destroy, :id => upcategories(:one).to_param
    end

    assert_redirected_to upcategories_path
  end
end

require 'test_helper'

class OscarsControllerTest < ActionController::TestCase
  setup do
    @oscar = oscars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oscars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oscar" do
    assert_difference('Oscar.count') do
      post :create, oscar: { category: @oscar.category }
    end

    assert_redirected_to oscar_path(assigns(:oscar))
  end

  test "should show oscar" do
    get :show, id: @oscar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @oscar
    assert_response :success
  end

  test "should update oscar" do
    put :update, id: @oscar, oscar: { category: @oscar.category }
    assert_redirected_to oscar_path(assigns(:oscar))
  end

  test "should destroy oscar" do
    assert_difference('Oscar.count', -1) do
      delete :destroy, id: @oscar
    end

    assert_redirected_to oscars_path
  end
end

require 'test_helper'

class ModifiesControllerTest < ActionController::TestCase
  setup do
    @modify = modifies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:modifies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create modify" do
    assert_difference('Modify.count') do
      post :create, modify: { action: @modify.action, data: @modify.data, mid: @modify.mid, uid: @modify.uid }
    end

    assert_redirected_to modify_path(assigns(:modify))
  end

  test "should show modify" do
    get :show, id: @modify
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @modify
    assert_response :success
  end

  test "should update modify" do
    put :update, id: @modify, modify: { action: @modify.action, data: @modify.data, mid: @modify.mid, uid: @modify.uid }
    assert_redirected_to modify_path(assigns(:modify))
  end

  test "should destroy modify" do
    assert_difference('Modify.count', -1) do
      delete :destroy, id: @modify
    end

    assert_redirected_to modifies_path
  end
end

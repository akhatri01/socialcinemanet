require 'test_helper'

class TopUsersControllerTest < ActionController::TestCase
  setup do
    @top_user = top_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:top_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create top_user" do
    assert_difference('TopUser.count') do
      post :create, top_user: {  }
    end

    assert_redirected_to top_user_path(assigns(:top_user))
  end

  test "should show top_user" do
    get :show, id: @top_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @top_user
    assert_response :success
  end

  test "should update top_user" do
    put :update, id: @top_user, top_user: {  }
    assert_redirected_to top_user_path(assigns(:top_user))
  end

  test "should destroy top_user" do
    assert_difference('TopUser.count', -1) do
      delete :destroy, id: @top_user
    end

    assert_redirected_to top_users_path
  end
end

require 'test_helper'

class CreateUsersArchivesControllerTest < ActionController::TestCase
  setup do
    @create_users_archive = create_users_archives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:create_users_archives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create create_users_archive" do
    assert_difference('CreateUsersArchive.count') do
      post :create, create_users_archive: {  }
    end

    assert_redirected_to create_users_archive_path(assigns(:create_users_archive))
  end

  test "should show create_users_archive" do
    get :show, id: @create_users_archive
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @create_users_archive
    assert_response :success
  end

  test "should update create_users_archive" do
    put :update, id: @create_users_archive, create_users_archive: {  }
    assert_redirected_to create_users_archive_path(assigns(:create_users_archive))
  end

  test "should destroy create_users_archive" do
    assert_difference('CreateUsersArchive.count', -1) do
      delete :destroy, id: @create_users_archive
    end

    assert_redirected_to create_users_archives_path
  end
end

require 'test_helper'

class PNominatedsControllerTest < ActionController::TestCase
  setup do
    @p_nominated = p_nominateds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:p_nominateds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create p_nominated" do
    assert_difference('PNominated.count') do
      post :create, p_nominated: { mid: @p_nominated.mid, oid: @p_nominated.oid, pid: @p_nominated.pid, year: @p_nominated.year }
    end

    assert_redirected_to p_nominated_path(assigns(:p_nominated))
  end

  test "should show p_nominated" do
    get :show, id: @p_nominated
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @p_nominated
    assert_response :success
  end

  test "should update p_nominated" do
    put :update, id: @p_nominated, p_nominated: { mid: @p_nominated.mid, oid: @p_nominated.oid, pid: @p_nominated.pid, year: @p_nominated.year }
    assert_redirected_to p_nominated_path(assigns(:p_nominated))
  end

  test "should destroy p_nominated" do
    assert_difference('PNominated.count', -1) do
      delete :destroy, id: @p_nominated
    end

    assert_redirected_to p_nominateds_path
  end
end

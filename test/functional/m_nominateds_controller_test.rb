require 'test_helper'

class MNominatedsControllerTest < ActionController::TestCase
  setup do
    @m_nominated = m_nominateds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_nominateds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_nominated" do
    assert_difference('MNominated.count') do
      post :create, m_nominated: { mid: @m_nominated.mid, oid: @m_nominated.oid, year: @m_nominated.year }
    end

    assert_redirected_to m_nominated_path(assigns(:m_nominated))
  end

  test "should show m_nominated" do
    get :show, id: @m_nominated
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_nominated
    assert_response :success
  end

  test "should update m_nominated" do
    put :update, id: @m_nominated, m_nominated: { mid: @m_nominated.mid, oid: @m_nominated.oid, year: @m_nominated.year }
    assert_redirected_to m_nominated_path(assigns(:m_nominated))
  end

  test "should destroy m_nominated" do
    assert_difference('MNominated.count', -1) do
      delete :destroy, id: @m_nominated
    end

    assert_redirected_to m_nominateds_path
  end
end

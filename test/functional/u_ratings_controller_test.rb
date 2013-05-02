require 'test_helper'

class URatingsControllerTest < ActionController::TestCase
  setup do
    @u_rating = u_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:u_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create u_rating" do
    assert_difference('URating.count') do
      post :create, u_rating: { mid: @u_rating.mid, uid: @u_rating.uid }
    end

    assert_redirected_to u_rating_path(assigns(:u_rating))
  end

  test "should show u_rating" do
    get :show, id: @u_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @u_rating
    assert_response :success
  end

  test "should update u_rating" do
    put :update, id: @u_rating, u_rating: { mid: @u_rating.mid, uid: @u_rating.uid }
    assert_redirected_to u_rating_path(assigns(:u_rating))
  end

  test "should destroy u_rating" do
    assert_difference('URating.count', -1) do
      delete :destroy, id: @u_rating
    end

    assert_redirected_to u_ratings_path
  end
end

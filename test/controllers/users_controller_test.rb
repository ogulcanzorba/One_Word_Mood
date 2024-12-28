require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)  # Assuming you have a user fixture named :one
    sign_in @user        # Devise helper: logs in the @user
  end

  test "should get index" do
    get users_url
    assert_response :success
    # removed assigns(:users)
  end

  test "should get new" do
    # NOTE: This requires that your routes have 'new' for users, e.g. resources :users
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    # NOTE: This also requires a routes definition that allows POST /users to create a user.
    assert_difference("User.count", 1) do
      post users_url, params: {
        user: {
          name:  "Test User",
          email: "test@example.com",
          password: "password"
        }
      }
    end
    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: {
      user: {
        name: "Updated Name"
      }
    }
    assert_redirected_to user_url(@user)

    @user.reload
    assert_equal "Updated Name", @user.name
  end

  test "should destroy user" do
    # This assumes you actually allow user destruction in your routes & controller
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_url
  end
end

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  # REMOVED test "should get new"

  test "should create user" do
    assert_difference("User.count", 1) do
      post users_url, params: {
        user: {
          name: "TestUser",
          handle: "testing1",
          email: "unique#{SecureRandom.hex}@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end
    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  # REMOVED test "should get edit"

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
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_url
  end
end

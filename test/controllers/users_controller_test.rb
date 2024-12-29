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

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should update user" do
    user = users(:one) # Assuming you have fixtures set up
    patch user_url(user), params: { user: { name: "Updated Name", email: "updated@example.com", handle: "updated_handle" } }
    assert_redirected_to user_url(user)
  end


  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_url
  end
end

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count", 1) do
      post posts_url, params: {
        post: { mood_word: "Happy", content: "Feeling great today!", gif_url: "http://example.com/happy.gif" }
      }
    end
    assert_redirected_to posts_url # Ensure redirect matches the controller's create action
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: {
      post: { mood_word: "Depressed", content: "Feeling down.", gif_url: "http://example.com/sad.gif" }
    }
    assert_redirected_to posts_url # Match controller's update action redirection
    @post.reload
    assert_equal "Depressed", @post.mood_word
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url # Match controller's destroy action redirection
  end
end

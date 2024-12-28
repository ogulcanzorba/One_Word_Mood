require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)      # Assuming you have a fixture named :one in posts.yml
    @user = users(:one)      # Devise user fixture
    sign_in @user            # Devise helper to authenticate
  end

  test "should get index" do
    get posts_url
    assert_response :success
    # removed assigns(:posts) because that requires the rails-controller-testing gem
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count", 1) do
      post posts_url, params: {
        post: {
          content: "This is a test content."
          # If your Post requires a mood_word or other attributes, add them here
        }
      }
    end
    assert_redirected_to post_url(Post.last)
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
      post: {
        content: "Updated content."
        # Add or remove attributes if your model requires them
      }
    }
    assert_redirected_to post_url(@post)

    @post.reload
    assert_equal "Updated content.", @post.content
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url
  end
end

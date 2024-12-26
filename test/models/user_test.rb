require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(name: 'Test User', email: 'test@example.com', password: 'password')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be valid format" do
    invalid_emails = ["user@foo,com", "user_at_foo.org", "user.name@example."]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end

  test "password should be present" do
    @user.password = " "
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = "short"
    assert_not @user.valid?
  end
end

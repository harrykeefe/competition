require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should not save user name, account type, email and password" do
    user = User.new
    user.valid?
    assert_not_empty user.errors
  end

  test "should save user with valid sign up information" do
    user = users(:free_user)
    assert user.save
  end

end

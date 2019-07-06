require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest

  test "signup new user" do
    get signup_path
	assert_template 'users/new'
	assert_difference 'User.count', 1 do
	  post users_path, params:{user:{username: "daisy8", email: "daisy8@example.com", password: "password", admin: true}}
	  follow_redirect!
	end
	assert_template 'users/show'
	assert_match "daisy8", response.body
  end
end
require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
  end

  test "create new article" do
    sign_in_as(@user, "password")
    get new_article_path
	assert_template 'articles/new'
	assert_difference 'Article.count', 1 do
	  post articles_path, params:{article:{title: "title new test", description: "description new test", user_id: @user.id}}
	  follow_redirect!
	end
	assert_template 'articles/show'
	assert_match "title new test", response.body
  end
end
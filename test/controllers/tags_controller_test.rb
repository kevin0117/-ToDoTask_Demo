require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get tags inded" do
    get tags_path

    assert_response :success
  end

  test "should get new" do
    get new_tag_path

    assert_response :success
  end

  test "should get show" do
    get tag_path

    assert_response :success
  end
end
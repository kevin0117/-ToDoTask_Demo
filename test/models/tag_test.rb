require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
      @tag = Tag.new(name: "food")
    end
  
    test "tag should be valid" do
      assert @tag.valid?
    end
  
    test "name should be present" do
      @tag.name = " "
      assert_not @tag.valid?
    end

    test "name should be unique" do
      @tag.save
      @new_tag = Tag.new(name: "food")

      assert_not @new_tag.valid?
    end

    test "name should not be too long" do
      @tag.name = "a" * 16
      assert_not @tag.valid?
    end

    test "name should not be too short" do
      @tag.name = "aa"
      assert_not @tag.valid?
    end
end



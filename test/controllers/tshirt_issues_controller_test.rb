require 'test_helper'

class TshirtIssuesControllerTest < ActionController::TestCase
  setup do
    @tshirt_issue = tshirt_issues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tshirt_issues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tshirt_issue" do
    assert_difference('TshirtIssue.count') do
      post :create, tshirt_issue: { comment: @tshirt_issue.comment, member_id: @tshirt_issue.member_id, tshirt_definition_id: @tshirt_issue.tshirt_definition_id }
    end

    assert_redirected_to tshirt_issue_path(assigns(:tshirt_issue))
  end

  test "should show tshirt_issue" do
    get :show, id: @tshirt_issue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tshirt_issue
    assert_response :success
  end

  test "should update tshirt_issue" do
    patch :update, id: @tshirt_issue, tshirt_issue: { comment: @tshirt_issue.comment, member_id: @tshirt_issue.member_id, tshirt_definition_id: @tshirt_issue.tshirt_definition_id }
    assert_redirected_to tshirt_issue_path(assigns(:tshirt_issue))
  end

  test "should destroy tshirt_issue" do
    assert_difference('TshirtIssue.count', -1) do
      delete :destroy, id: @tshirt_issue
    end

    assert_redirected_to tshirt_issues_path
  end
end

require 'test_helper'

class LockLogsControllerTest < ActionController::TestCase
  setup do
    @lock_log = lock_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lock_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lock_log" do
    assert_difference('LockLog.count') do
      post :create, lock_log: { card_id: @lock_log.card_id }
    end

    assert_redirected_to lock_log_path(assigns(:lock_log))
  end

  test "should show lock_log" do
    get :show, id: @lock_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lock_log
    assert_response :success
  end

  test "should update lock_log" do
    patch :update, id: @lock_log, lock_log: { card_id: @lock_log.card_id }
    assert_redirected_to lock_log_path(assigns(:lock_log))
  end

  test "should destroy lock_log" do
    assert_difference('LockLog.count', -1) do
      delete :destroy, id: @lock_log
    end

    assert_redirected_to lock_logs_path
  end
end

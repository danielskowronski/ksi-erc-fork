require 'test_helper'

class TshirtDefinitionsControllerTest < ActionController::TestCase
  setup do
    @tshirt_definition = tshirt_definitions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tshirt_definitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tshirt_definition" do
    assert_difference('TshirtDefinition.count') do
      post :create, tshirt_definition: { comments: @tshirt_definition.comments, image: @tshirt_definition.image, name: @tshirt_definition.name, produced: @tshirt_definition.produced }
    end

    assert_redirected_to tshirt_definition_path(assigns(:tshirt_definition))
  end

  test "should show tshirt_definition" do
    get :show, id: @tshirt_definition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tshirt_definition
    assert_response :success
  end

  test "should update tshirt_definition" do
    patch :update, id: @tshirt_definition, tshirt_definition: { comments: @tshirt_definition.comments, image: @tshirt_definition.image, name: @tshirt_definition.name, produced: @tshirt_definition.produced }
    assert_redirected_to tshirt_definition_path(assigns(:tshirt_definition))
  end

  test "should destroy tshirt_definition" do
    assert_difference('TshirtDefinition.count', -1) do
      delete :destroy, id: @tshirt_definition
    end

    assert_redirected_to tshirt_definitions_path
  end
end

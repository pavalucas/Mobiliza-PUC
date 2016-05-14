require 'test_helper'

class MobilizationsControllerTest < ActionController::TestCase
  setup do
    @mobilization = mobilizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mobilizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mobilization" do
    assert_difference('Mobilization.count') do
      post :create, mobilization: { category: @mobilization.category, description: @mobilization.description, mail_content: @mobilization.mail_content, title: @mobilization.title }
    end

    assert_redirected_to mobilization_path(assigns(:mobilization))
  end

  test "should show mobilization" do
    get :show, id: @mobilization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mobilization
    assert_response :success
  end

  test "should update mobilization" do
    patch :update, id: @mobilization, mobilization: { category: @mobilization.category, description: @mobilization.description, mail_content: @mobilization.mail_content, title: @mobilization.title }
    assert_redirected_to mobilization_path(assigns(:mobilization))
  end

  test "should destroy mobilization" do
    assert_difference('Mobilization.count', -1) do
      delete :destroy, id: @mobilization
    end

    assert_redirected_to mobilizations_path
  end
end

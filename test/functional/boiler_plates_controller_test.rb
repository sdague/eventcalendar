require 'test_helper'

class BoilerPlatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boiler_plates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boiler_plate" do
    assert_difference('BoilerPlate.count') do
      post :create, :boiler_plate => { }
    end

    assert_redirected_to boiler_plate_path(assigns(:boiler_plate))
  end

  test "should show boiler_plate" do
    get :show, :id => boiler_plates(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => boiler_plates(:one).id
    assert_response :success
  end

  test "should update boiler_plate" do
    put :update, :id => boiler_plates(:one).id, :boiler_plate => { }
    assert_redirected_to boiler_plate_path(assigns(:boiler_plate))
  end

  test "should destroy boiler_plate" do
    assert_difference('BoilerPlate.count', -1) do
      delete :destroy, :id => boiler_plates(:one).id
    end

    assert_redirected_to boiler_plates_path
  end
end

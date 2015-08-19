require 'test_helper'

class Pc::WorkpiecesControllerTest < ActionController::TestCase
  setup do
    @pc_workpiece = pc_workpieces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pc_workpieces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pc_workpiece" do
    assert_difference('Pc::Workpiece.count') do
      post :create, pc_workpiece: {  }
    end

    assert_redirected_to pc_workpiece_path(assigns(:pc_workpiece))
  end

  test "should show pc_workpiece" do
    get :show, id: @pc_workpiece
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pc_workpiece
    assert_response :success
  end

  test "should update pc_workpiece" do
    patch :update, id: @pc_workpiece, pc_workpiece: {  }
    assert_redirected_to pc_workpiece_path(assigns(:pc_workpiece))
  end

  test "should destroy pc_workpiece" do
    assert_difference('Pc::Workpiece.count', -1) do
      delete :destroy, id: @pc_workpiece
    end

    assert_redirected_to pc_workpieces_path
  end
end

require 'test_helper'

class Pc::StagesControllerTest < ActionController::TestCase
  setup do
    @pc_stage = pc_stages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pc_stages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pc_stage" do
    assert_difference('Pc::Stage.count') do
      post :create, pc_stage: {  }
    end

    assert_redirected_to pc_stage_path(assigns(:pc_stage))
  end

  test "should show pc_stage" do
    get :show, id: @pc_stage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pc_stage
    assert_response :success
  end

  test "should update pc_stage" do
    patch :update, id: @pc_stage, pc_stage: {  }
    assert_redirected_to pc_stage_path(assigns(:pc_stage))
  end

  test "should destroy pc_stage" do
    assert_difference('Pc::Stage.count', -1) do
      delete :destroy, id: @pc_stage
    end

    assert_redirected_to pc_stages_path
  end
end

require 'test_helper'

class Pc::ProceduresControllerTest < ActionController::TestCase
  setup do
    @pc_procedure = pc_procedures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pc_procedures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pc_procedure" do
    assert_difference('Pc::Procedure.count') do
      post :create, pc_procedure: {  }
    end

    assert_redirected_to pc_procedure_path(assigns(:pc_procedure))
  end

  test "should show pc_procedure" do
    get :show, id: @pc_procedure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pc_procedure
    assert_response :success
  end

  test "should update pc_procedure" do
    patch :update, id: @pc_procedure, pc_procedure: {  }
    assert_redirected_to pc_procedure_path(assigns(:pc_procedure))
  end

  test "should destroy pc_procedure" do
    assert_difference('Pc::Procedure.count', -1) do
      delete :destroy, id: @pc_procedure
    end

    assert_redirected_to pc_procedures_path
  end
end

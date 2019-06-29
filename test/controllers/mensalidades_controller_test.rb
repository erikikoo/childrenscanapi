require 'test_helper'

class MensalidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mensalidade = mensalidades(:one)
  end

  test "should get index" do
    get mensalidades_url, as: :json
    assert_response :success
  end

  test "should create mensalidade" do
    assert_difference('Mensalidade.count') do
      post mensalidades_url, params: { mensalidade: { child_id: @mensalidade.child_id, status: @mensalidade.status, user_id: @mensalidade.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show mensalidade" do
    get mensalidade_url(@mensalidade), as: :json
    assert_response :success
  end

  test "should update mensalidade" do
    patch mensalidade_url(@mensalidade), params: { mensalidade: { child_id: @mensalidade.child_id, status: @mensalidade.status, user_id: @mensalidade.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy mensalidade" do
    assert_difference('Mensalidade.count', -1) do
      delete mensalidade_url(@mensalidade), as: :json
    end

    assert_response 204
  end
end

require 'test_helper'

class EscolasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @escola = escolas(:one)
  end

  test "should get index" do
    get escolas_url, as: :json
    assert_response :success
  end

  test "should create escola" do
    assert_difference('Escola.count') do
      post escolas_url, params: { escola: { nome: @escola.nome, user_id: @escola.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show escola" do
    get escola_url(@escola), as: :json
    assert_response :success
  end

  test "should update escola" do
    patch escola_url(@escola), params: { escola: { nome: @escola.nome, user_id: @escola.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy escola" do
    assert_difference('Escola.count', -1) do
      delete escola_url(@escola), as: :json
    end

    assert_response 204
  end
end

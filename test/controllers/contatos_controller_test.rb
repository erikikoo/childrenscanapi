require 'test_helper'

class ContatosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contato = contatos(:one)
  end

  test "should get index" do
    get contatos_url, as: :json
    assert_response :success
  end

  test "should create contato" do
    assert_difference('Contato.count') do
      post contatos_url, params: { contato: { email: @contato.email, site: @contato.site, telefone: @contato.telefone } }, as: :json
    end

    assert_response 201
  end

  test "should show contato" do
    get contato_url(@contato), as: :json
    assert_response :success
  end

  test "should update contato" do
    patch contato_url(@contato), params: { contato: { email: @contato.email, site: @contato.site, telefone: @contato.telefone } }, as: :json
    assert_response 200
  end

  test "should destroy contato" do
    assert_difference('Contato.count', -1) do
      delete contato_url(@contato), as: :json
    end

    assert_response 204
  end
end

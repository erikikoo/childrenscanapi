require 'test_helper'

class ChildrenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @child = children(:one)
  end

  test "should get index" do
    get children_url, as: :json
    assert_response :success
  end

  test "should create child" do
    assert_difference('Child.count') do
      post children_url, params: { child: { contato_responsavel: @child.contato_responsavel, data_nascimento: @child.data_nascimento, nome: @child.nome, parentesco: @child.parentesco, responsavel: @child.responsavel, sexo: @child.sexo, status: @child.status } }, as: :json
    end

    assert_response 201
  end

  test "should show child" do
    get child_url(@child), as: :json
    assert_response :success
  end

  test "should update child" do
    patch child_url(@child), params: { child: { contato_responsavel: @child.contato_responsavel, data_nascimento: @child.data_nascimento, nome: @child.nome, parentesco: @child.parentesco, responsavel: @child.responsavel, sexo: @child.sexo, status: @child.status } }, as: :json
    assert_response 200
  end

  test "should destroy child" do
    assert_difference('Child.count', -1) do
      delete child_url(@child), as: :json
    end

    assert_response 204
  end
end

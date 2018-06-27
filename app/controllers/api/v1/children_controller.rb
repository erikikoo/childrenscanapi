module Api::V1
  class ChildrenController < ApplicationController
    before_action :authenticate_request
    before_action :set_child, only: [:show, :update, :destroy]
    before_action :getAllChildren, only: [:index, :create, :destroy]
    # GET /children
    def index
      render json: @children, :include => {:user => {:only => :name}}      
    end

    # GET /children/1
    def show
      render json: @child, :include => {:user => {:only => :name}}
    end

    # POST /children
    def create
      @child = Child.new(child_params)

      if @child.save
        render json: @children, status: :created
      else
        render json: @child.errors, status: :unprocessable_entity,  message: 'Aluno cadastrado com sucesso!'
      end
    end

    # PATCH/PUT /children/1
    def update
      if @child.update(child_params)
        render json: @child
      else
        render json: @child.errors, status: :unprocessable_entity
      end
    end

    # DELETE /children/1
    def destroy
      @child.destroy
    end

    private
      
    def getAllChildren
      #monitor = User.find(@current_user)
      if (@current_user.level == 3) 
        @children = Child.all.order(user_id: :asc)
       else 
        @children = Child.where(user_id: @current_user)#.includes(:monitor_user)
       end
    end
    
    
    # Use callbacks to share common setup or constraints between actions.
      def set_child
        @child = Child.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def child_params
        params.require(:child).permit(:nome, :contato, :nascimento, :responsavel, :parentesco, :sexo, :status, :user_id)
      end
  end
end
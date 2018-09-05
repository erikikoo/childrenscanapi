module Api::V1
  class ChildrenController < ApplicationController
    before_action :authenticate_request
    before_action :set_child, only: [:show, :update, :destroy, :update_status]
    before_action :getAllChildren, only: [:index, :create, :destroy, :generate_qr_code]
    
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
      #@child.parentesco = params[:parentesco].to_i
      #@child.sexo = params[:sexo].to_i
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

    def generate_qr_code      
      getAllChildrenOfUser(params[:id])
      render json: @children, :include => {:user => {:only => :name}} 
    end

    def update_status
      if @child.status == 'ativo'
        @child.update(status: 0)
      elsif @child.status == 'desativado'
        @child.update(status: 1)
      end    
      if @child.save!
        getAllChildren()
        render json: @children, :include => {:user => {:only => :name}}
      else
        render json: @children.errors, status: :unprocessable_entity
      end
    end


    private
      
    def getAllChildren
      #monitor = User.find(@current_user)
      if (@current_user.level == 3) 
        @children = Child.all.order(user_id: :asc)
       else 
        @children = Child.where(user_id: @current_user)
       end
    end
    
    def getAllChildrenOfUser(id='')
      unless id
        @children = Child.where(user_id: @current_user)
      else
        @children = Child.where(user_id: id)
      end
    end  
    # Use callbacks to share common setup or constraints between actions.
      def set_child
        @child = Child.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def child_params
        params.require(:child).permit(:name, :contato, :nascimento, :responsavel, :parentesco, :sexo, :status, :user_id)
      end
  end
end
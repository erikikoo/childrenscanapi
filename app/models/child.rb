class Child < ApplicationRecord
    has_many :sms_messages, dependent: :destroy    
    belongs_to :user
    
    enum parentesco: [:mae, :pai, :outros]
    enum sexo: [:feminino, :masculino]
    enum status: [:desativado, :ativo]
    
    validates :name, uniqueness: { scope: :contato, case_sensitive: false , message: "Ops!, este nome JÁ ESTÁ CADASTRADO neste número de telefone" }    
    validates_presence_of :name, :contato, :responsavel, :parentesco, :sexo  

    # scope :last_child, -> (limit) { where("created_at >= ?", Time.now.to_date).limit(limit) }
   
    
    def self.allChild(user)
        if user.level === 3
            Child.all.order(:monitor_user_id)
        else
            Child.where(monitor_user_id: user.id).order("created_at DESC")
        end
    end
end

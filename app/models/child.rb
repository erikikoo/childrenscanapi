class Child < ApplicationRecord
    belongs_to :user
    
    belongs_to :escola# through: :user
    
    has_many :notifications, dependent: :destroy
    
    has_many :device_children, dependent: :destroy
    has_many :devices, through: :device_children

    has_many :event_children, dependent: :destroy
    has_many :events, through: :event_children

    has_many :mensalidades, dependent: :destroy

    # has_many :notification_devices    
    accepts_nested_attributes_for :devices, :allow_destroy => true
    
    enum sexo: [:feminino, :masculino]
    enum status: [:desativado, :ativo]
    enum perido: [:manha, :intermediario, :tarde, :noite]
    enum tipo_viagem: [:ida_volta, :ida, :volta]
    
    # validates :name, uniqueness: { scope: :contato, case_sensitive: false , message: "Ops!, este nome JÁ ESTÁ CADASTRADO neste número de telefone" }    
    validates_presence_of :name, :contato, :responsavel, :sexo  


    # scope :last_child, -> (limit) { where("created_at >= ?", Time.now.to_date).limit(limit) }
   
    
    def self.allChild(user)
        if user.level === 3
            Child.all.order(:monitor_user_id)
        else
            Child.where(monitor_user_id: user.id).order("created_at DESC")
        end
    end
end

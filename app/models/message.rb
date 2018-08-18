class Message < ApplicationRecord
  belongs_to :user

  enum periodo: [:manha, :matutino, :tarde, :vespertino]
  enum acao: [:entrada, :saida]

  validates_presence_of :acao, :periodo, :message_text, :user_id, message: "Ops!, todos os campos são obrigatórios"
  validates :acao, uniqueness: { scope: :periodo, case_sensitive: false , message: "Ops!, JÁ foi definido mensagem para está ação e período" }    
end

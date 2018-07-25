class Ticket < ApplicationRecord
  belongs_to :user
  has_many :answers
  
  enum status: [:fechado, :aberto]
end

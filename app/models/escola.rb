class Escola < ApplicationRecord
  belongs_to :user  
  has_many :children 

  has_many :escola_alerts, dependent: :destroy
  has_many :alerts, through: :escola_alerts
end

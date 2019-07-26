class Alert < ApplicationRecord
  belongs_to :user

  has_many :escola_alerts, dependent: :destroy
  has_many :escolas, through: :escola_alerts
end

class Event < ApplicationRecord
  belongs_to :user

  has_many :event_devices, dependent: :destroy
  has_many :devices, through: :event_devices
end

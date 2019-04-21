class Event < ApplicationRecord
  belongs_to :user 
  
  has_many :event_devices, dependent: :destroy
  has_many :devices, through: :event_devices

  has_many :event_children
  has_many :children, through: :event_children

  has_one_attached :image

  
 end

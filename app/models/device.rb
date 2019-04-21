class Device < ApplicationRecord
    has_many :device_children, dependent: :destroy
    has_many :children, through: :device_children

    has_many :event_devices, dependent: :destroy
    has_many :events, through: :event_devices

    validates_presence_of :uid_device, :uid_onesignal
end

class DeviceChild < ApplicationRecord
  belongs_to :child
  belongs_to :device
end

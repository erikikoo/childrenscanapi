class EventChild < ApplicationRecord
  belongs_to :child, optional: true
  belongs_to :event
end

class EventDevice < ApplicationRecord
  belongs_to :event
  belongs_to :device

  enum visited: [:no, :yes]

end

class Mensalidade < ApplicationRecord
  belongs_to :user
  belongs_to :child
end

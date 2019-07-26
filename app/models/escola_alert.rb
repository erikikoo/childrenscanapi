class EscolaAlert < ApplicationRecord
  belongs_to :escola, optional: true
  belongs_to :alert
end

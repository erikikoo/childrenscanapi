class Answer < ApplicationRecord
  belongs_to :ticket

  enum status: [:nao_visualizado, :visualizado]
end

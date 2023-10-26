class Answer < ApplicationRecord
  belongs_to :question

  validates :score, :label, presence: true
end

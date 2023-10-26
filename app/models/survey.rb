class Survey < ApplicationRecord
  has_many :survey_answers
  has_many :answers, through: :survey_answers

  validates :score, :session_id, presence: true
end

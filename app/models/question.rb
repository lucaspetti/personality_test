class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :survey_type, :title, presence: true
  validates :title, uniqueness: { scope: :survey_type, message: "cannot be repeated for same survey type" }

  scope :for_survey_type, -> (survey_type) { includes(:answers).where("survey_type = ?", survey_type) }
end

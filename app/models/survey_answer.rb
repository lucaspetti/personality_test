class SurveyAnswer < ApplicationRecord
  belongs_to :survey
  belongs_to :answer
end

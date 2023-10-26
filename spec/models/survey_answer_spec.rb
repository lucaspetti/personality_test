require 'rails_helper'

RSpec.describe SurveyAnswer, type: :model do
  it { is_expected.to belong_to(:survey) }
  it { is_expected.to belong_to(:answer) }
end

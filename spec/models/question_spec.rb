require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to validate_presence_of(:survey_type) }
  it { is_expected.to validate_presence_of(:title) }

  it do
    is_expected.to validate_uniqueness_of(:title).scoped_to(:survey_type)
      .with_message('cannot be repeated for same survey type')
  end
end

require 'rails_helper'

RSpec.describe Survey::Factory do
  let(:factory) { described_class.new(survey_params) }
  let(:survey_params) do
    {
      "session_id" => "mock_id",
      "answer_1" => "2",
      "answer_2" => "2",
      "answer_3" => "2",
      "answer_4" => "2"
    }.with_indifferent_access
  end

  describe '#create' do
    context 'when it is successful' do
      let(:mock_survey) { instance_double(Survey) }

      before do
        allow(Survey).to receive(:create!).and_return(mock_survey)
      end

      it 'returns the created survey' do
        expect(factory.create).to eq(mock_survey)
      end
    end

    context 'when it is not successful' do
      before do
        allow(Survey).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
      end

      it 'returns nil' do
        expect(factory.create).to be_nil
      end
    end
  end
end

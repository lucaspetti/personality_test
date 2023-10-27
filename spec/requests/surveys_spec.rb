require "rails_helper"

RSpec.describe "Surveys", type: :request do
  describe "GET /new" do
    context "when user already did a survey" do
      let(:survey) { Survey.create(score: 10, session_id: 'mock_id') }

      before do
        allow(Survey).to receive(:find_by).and_return(survey)
      end

      it "renders flash message and returns http success" do
        get "/test"
        expect(response.body).to include("Already did a survey?")
        expect(response).to have_http_status(:success)
      end
    end

    context "when user did not do a survey" do
      before do
        allow(Survey).to receive(:find_by).and_return(nil)
      end

      it "returns http success" do
        get "/test"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST /create" do
    let(:params) do
      { survey: { question_one: "1", question_two: "4" } }
    end
    let(:mock_survey_creator) { instance_double(Survey::Factory) }

    before do
      allow(Survey::Factory).to receive(:new).and_return(mock_survey_creator)
      allow(mock_survey_creator).to receive(:create).and_return(mock_survey)
      post "/surveys", params: params
    end

    context "when survey is persisted" do
      let(:mock_survey) { instance_double(Survey) }

      it "returns http success" do
        expect(response).to redirect_to(survey_path(mock_survey))
      end
    end

    context "when there is an error or survey is not persisted" do
      let(:mock_survey) { nil }

      it "redirects user back to test" do
        expect(response).to redirect_to("/test")
      end
    end
  end

  describe "GET /show" do
    context "when it is successful" do
      let(:mock_survey) { instance_double(Survey, score: 5) }

      before do
        allow(Survey).to receive(:find).with("1").and_return(mock_survey)
      end

      it "returns http success" do
        get "/surveys/1"
        expect(response).to have_http_status(:success)
      end
    end

    context "when survey is not found" do
      it "returns http not found" do
        get "/surveys/1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

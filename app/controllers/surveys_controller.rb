class SurveysController < ApplicationController
  def new
    previous_survey = fetch_survey_by_user_session
    if previous_survey
      link = "<a href=\"#{url_for(previous_survey)}\">Check it here</a>"
      flash.now[:notice] = "Already did a survey? #{link}".html_safe
    end

    @questions = Question.for_survey_type("personality_test")
    @survey = Survey.new
  end

  def create
    survey_creator = Survey::Factory.new(survey_params)
    survey = survey_creator.create

    if survey
      redirect_to survey_path(survey)
    else
      redirect_to "/test", alert: "Something went wrong"
    end
  end

  def show
    survey_id = params[:id]
    @survey = Survey.find(survey_id)

  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end

  private

  def fetch_survey_by_user_session
    session_id = session.id&.public_id
    Survey.find_by(session_id: session_id)
  end

  def survey_params
    params.require(:survey).permit!.tap do |survey|
      survey[:session_id] = session.id
    end
  end
end

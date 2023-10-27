class Survey::Factory
  attr_reader :survey_params, :session_id

  def initialize(survey_params)
    @session_id = survey_params.delete(:session_id)
    @survey_params = survey_params
  end

  def create
    score = calculate_score
    Survey.create!(session_id: session_id, score: score)
  rescue ActiveRecord::RecordInvalid => e
    # TODO: could log the error here
  end

  private

  def calculate_score
    survey_params.values.map(&:to_i).sum
  end
end

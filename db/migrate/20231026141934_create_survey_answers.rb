class CreateSurveyAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_answers do |t|
      t.references :survey, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

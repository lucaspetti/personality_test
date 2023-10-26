class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :survey_type
      t.string :title

      t.timestamps
    end
  end
end

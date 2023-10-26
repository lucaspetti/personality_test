class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.integer :score
      t.string :session_id

      t.timestamps
    end
  end
end

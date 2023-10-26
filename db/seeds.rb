# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

questions_data = [
  {
    title: "You're really busy at work and a colleague is telling you their life story and personal woes. You:",
    survey_type: "personality_test",
    answers: [
      { score: 1, label: "Don't dare to interrupt them" },
      { score: 2, label: "Think it's more important to give them some of your time; work can wait" },
      { score: 3, label: "Listen, but with only with half an ear" },
      { score: 4, label: "Interrupt and explain that you are really busy at the moment" },
    ]
  },
  {
    title: "You've been sitting in the doctor's waiting room for more than 25 minutes. You:",
    survey_type: "personality_test",
    answers: [
      { score: 1, label: "Look at your watch every two minutes" },
      { score: 2, label: "Bubble with inner anger, but keep quiet" },
      { score: 3, label: "Explain to other equally impatient people in the room that the doctor is always running late" },
      { score: 4, label: "Complain in a loud voice, while tapping your foot impatiently" },
    ]
  },
  {
    title: "You're having an animated discussion with a colleague regarding a project that you're in charge of. You:",
    survey_type: "personality_test",
    answers: [
      { score: 1, label: "Don't dare contradict them" },
      { score: 2, label: "Think that they are obviously right" },
      { score: 3, label: "Defend your own point of view, tooth and nail" },
      { score: 4, label: "Continuously interrupt your colleague" },
    ]
  }
]

questions_data.each do |question_data|
  title = question_data[:title]
  survey_type = question_data[:survey_type]

  question = Question.create!(title: title, survey_type: survey_type)

  answers = question_data[:answers]
  answers.each do |answer|
    answer[:question_id] = question.id
    Answer.create!(answer)
  end
rescue ActiveRecord::RecordInvalid => invalid
  puts "Could not create #{invalid.record.class}: #{invalid.message}"
end

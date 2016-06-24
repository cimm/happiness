fixed_questions = [
  "Are you feeling happy now?"
]

fixed_questions.each do |question|
  Question.create!(body: question, regularity: 'fixed')
end

flexible_questions = [
  "How do you feel about the opportunities to grow and learn at work?",
  "How do you feel about the importance of the work that you do?",
  "How energising are your interactions at work?",
  "How do you feel about your workload?",
  "How would you rate your work-life balance today?",
  "What's the level of comfort you have at your work place?",
  "How do you feel about recommending a friend work at your company?",
  "How do you feel about the number of hours you spent working today?",
  "How encouraging was your manager today?",
  "How clearly defined were your expectations at work today?",
  "How would you rate your productivity today?",
  "How do you feel about the results you achieved today?",
  "How good do you feel about yourself?",
  "How satisfied are you about your accomplishments?",
  "How do you feel about your teammates' commitment to producing quality work?"
]

flexible_questions.each do |question|
  Question.create!(body: question, regularity: 'flexible')
end

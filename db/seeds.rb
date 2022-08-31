puts 'creating account ....'

# User
10.times do
  pwd = Faker::Internet.password
  hash = { first_name: Faker::Name.unique.name, email: Faker::Internet.email }
  hash.merge!({ password: pwd })
  user = User.new(hash)
  user.password_confirmation = pwd
  user.save
end

# Qestions
@user = User.first
puts 'creating questions ....'
50.times do
  title = Faker::Lorem.sentence
  body =  Faker::Lorem.sentence(word_count: 30)
  hash = { title: title, body: body }
  @user.questions.new(hash).save
end

# Answers
puts 'creating answer ....'

question = Question.first
100.times do
  body =  Faker::Lorem.sentence(word_count: 30)
  hash = { body: body }
  koment = question.answers.new(hash)
  koment.user = User.second
  koment.save
end
